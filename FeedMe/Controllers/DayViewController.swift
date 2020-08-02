//
//  DayViewController.swift
//  FeedMe
//
//  Created by Mathieu Delehaye on 7/7/20.
//  Copyright © 2020 Mathieu Delehaye. All rights reserved.
//

import UIKit
import RealmSwift 

class DayViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    let realm = try! Realm()
    
    var dayArray : Results<Day>?    // already created days
    
    var remainingDays: [String] = []    //  day list for picker view
    
    var modalRatio: Float?  // ratio to display modal views from days view
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
                
        tableView.dataSource = self // delegate for table view data source
        
        tableView.delegate = self   // delegate for table view events
        
        tableView.register(UINib(nibName: K.cellNibName, bundle: nil), forCellReuseIdentifier: K.cellIdentifier)    // register custom cell to table view 
        
        loadDays()  // read days from realm DB and load table view
    }
    
    // update day list for picker view by removing already created days without the selected one
    func updateRemainingDays(keepingDay selectedDay: String = "") {
        
        remainingDays = [ "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday", "Everyday" ]
        
        if var dayIterator = dayArray?.makeIterator() {
            
            while let existingDay = dayIterator.next() {
                
                if selectedDay != "" && existingDay.name == selectedDay {
                    
                    continue    // if selected name not empty, do not remove it from day list
                    
                }
                
                if let index = remainingDays.firstIndex(of: existingDay.name) {
                    
                    remainingDays.remove(at: index)
                    
                }
                
            }
        }
        
        print("remaining days: \(remainingDays)")
        
    }
       
    @IBAction func addDayPressed(_ sender: UIBarButtonItem) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
                
        let pvc = storyboard.instantiateViewController(withIdentifier: "PickerViewController") as! PickerViewController
        
        pvc.modalPresentationStyle = .custom
        
        pvc.transitioningDelegate = self
        
        updateRemainingDays()
        
        pvc.itemNames = remainingDays
         
        pvc.callbackViewDelegate = self
        
        modalRatio = Float(0.36)   // change modal ratio for picker view

        self.present(pvc, animated: true)
        
    }
    
    @IBAction func backButtonPressed(_ sender: UIBarButtonItem) {
        
        
    }
    
    //MARK: - Data Manipulation Methods
    func save(day: Day) {
                    
        do {
            try realm.write {
                realm.add(day)
            }
        } catch {
            print("Error saving context \(error)")
        }
        
        tableView.reloadData()
    }
        
    func loadDays() {

        dayArray = realm.objects(Day.self)
           
        tableView.reloadData()
        
    }
    
}

//MARK: - TableView Data Source Methods

extension DayViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dayArray?.count ?? 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: K.cellIdentifier, for: indexPath) as! DayCell
        
        if let day = dayArray?[indexPath.row] {
            cell.dayNameLabel.text = day.name
            cell.editor = self
            cell.row = indexPath.row
        }
  
        return cell
    }
    
}

//MARK: - TableView Delegate Methods
extension DayViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: "goToDayMeals", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let destinationVC = segue.destination as! MealViewController
                
        if let indexPath = tableView.indexPathForSelectedRow {
            
            tableView.deselectRow(at: indexPath, animated: true)
            
            destinationVC.selectedDay = dayArray?[indexPath.row]
        }
    }
        
}

//MARK: - ViewController Transitioning Delegate Methods
extension DayViewController: UIViewControllerTransitioningDelegate {
        
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
                
        return PartialSizePresentController(presentedViewController: presented, presenting: presenting, withRatio: modalRatio ?? 0.5)
        
    }
    
}

//MARK: - ViewController Cell Edition Delegate Methods
extension DayViewController: CellEdition {    
        
    func showEditionView(forCellAtRow cellRow: Int) {
           
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let evc = storyboard.instantiateViewController(withIdentifier: "EditViewController") as! EditViewController

        evc.modalPresentationStyle = .custom

        evc.transitioningDelegate = self

        if let day = dayArray?[cellRow] {

            updateRemainingDays(keepingDay: day.name)

            evc.itemNames = remainingDays
            
            evc.selectedItem = day

            evc.callbackViewDelegate = self
            
            modalRatio = Float(0.65)   // change modal ratio for picker view

            self.present(evc, animated: true)

        }
        
    }
    
}

//MARK: - ViewController Cell Edition Delegate Methods
extension DayViewController: CallbackViewManagement {
    
    func updateCBView() {
        
        loadDays()
        
    }
    
    func manageCBView(withObjectName objectName: String) {
        
        let newDay = Day()
        
        newDay.name = objectName
        
        save(day: newDay)
        
        loadDays()
        
    }
}
