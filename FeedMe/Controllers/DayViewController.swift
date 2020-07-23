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
    
    var dayArray : Results<Day>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        tableView.dataSource = self
        
        tableView.delegate = self
        
        tableView.register(UINib(nibName: K.cellNibName, bundle: nil), forCellReuseIdentifier: K.cellIdentifier)
        
        loadDays()
    }
        
    @IBAction func addDayPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Day", message:"", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add", style: .default) { (action) in
            
            let newDay = Day()
            newDay.name = textField.text!
            
            self.save(day: newDay)
        }
        
        alert.addTextField { (alertTextField) in
            textField.placeholder = "Create new day"
            textField = alertTextField
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
        
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
                
        return HalfSizePresentationController(presentedViewController: presented, presenting: presenting)
        
    }
    
}

//MARK: - ViewController Cell Edition Delegate Methods
extension DayViewController: CellEdition {    
        
    func showEditionView(forCellAtRow cellRow: Int) {
        
        //        let vc = EditViewController()
        //        vc.modalPresentationStyle = .custom
        //        present(vc, animated: true, completion: nil)
                
        let storyboard = UIStoryboard(name: "Main", bundle: nil)

        let pvc = storyboard.instantiateViewController(withIdentifier: "EditViewController") as! EditViewController

        pvc.modalPresentationStyle = .custom
        pvc.transitioningDelegate = self

        if let day = dayArray?[cellRow] {
            
            pvc.selectedItem = day
            pvc.callbackViewDelegate = self 
            
            self.present(pvc, animated: true) {
                
                print("returning")
                
                self.tableView.reloadData()
                
            }
            
        }
        
    }
    
}

//MARK: - ViewController Cell Edition Delegate Methods
extension DayViewController: CallbackViewManagement {
    
    func updateCBView() {
        
        loadDays()
        
    }
    
}
