//
//  DayViewController.swift
//  FeedMe
//
//  Created by Mathieu Delehaye on 7/7/20.
//  Copyright © 2020 Mathieu Delehaye. All rights reserved.
//

import UIKit
import RealmSwift 

class DayViewController: ListViewController {
    
    let fullDayList = [ "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday", "Everyday" ]
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
                
        tableView.dataSource = self // delegate for table view data source
        
        tableView.delegate = self   // delegate for table view events
        
        tableView.register(UINib(nibName: K.dayCellNibName, bundle: nil), forCellReuseIdentifier: K.cellIdentifier)    // register custom cell to table view 
        
        loadItems()  // read days from realm DB and load table view
    }
                   
    @IBAction func addDayPressed(_ sender: UIBarButtonItem) {
                
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let pvc = storyboard.instantiateViewController(withIdentifier: "PickerViewController") as! PickerViewController
        
        updateRemainingItems(keepingItem: "", fromStartList: fullDayList)
        
        presentModal(itemNames: remainingItems, forViewController: pvc)
    }
    
    //MARK: - Data Manipulation Methods
       
    override func save(item: AppItem) {
        
        do {
            try realm.write {
                
                if let dayToSave = item as? Day {
                    
                    realm.add(dayToSave)
                    
                }
            }
        } catch {
            print("Error saving context \(error)")
        }
        
    }
    
    override func loadItems() {

        let dayArray = realm.objects(Day.self).sorted(byKeyPath: "order", ascending: true)
        
        itemArray = []
        for day in dayArray {
            itemArray.append(day)
        }
        
        tableView.reloadData()
        
    }
    
}

//MARK: - TableView Data Source Methods

extension DayViewController {
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: K.cellIdentifier, for: indexPath) as! CustomCell
    
        let item = itemArray[indexPath.row]
        
        cell.nameLabel.text = item.name
        cell.editor = self
        cell.row = indexPath.row

        return cell
    }
    
}

//MARK: - TableView Delegate Methods
extension DayViewController {
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: K.DayToMealSegueIdentifier, sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let destinationVC = segue.destination as! MealViewController
        
        if let indexPath =  tableView.indexPathForSelectedRow {
            
            tableView.deselectRow(at: indexPath, animated: true)

            guard let selectedDay = itemArray[indexPath.row] as? Day else { fatalError("Error while retrieving selected item") }
                
            destinationVC.selectedDay = selectedDay
            
        }
    }
        
}

//MARK: - ViewController Cell Edition Delegate Methods
extension DayViewController {
        
    override func showEditionView(forCellAtRow cellRow: Int) {
           
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let evc = storyboard.instantiateViewController(withIdentifier: "EditViewController") as! EditViewController
        
        let selectedCellItem = itemArray[cellRow]
        
        evc.selectedItem = selectedCellItem
        
        updateRemainingItems(keepingItem: selectedCellItem.name, fromStartList: fullDayList)
        
        presentModal(itemNames: remainingItems, forViewController: evc)
        
    }
    
}

//MARK: - ViewController Cell Edition Delegate Methods
extension DayViewController {
    
    override func updateCBView() {
        
        loadItems()
        
    }
    
    override func manageCBView(withObjectName objectName: String) {
        
        let newDay = Day()
        
        newDay.name = objectName
        
        newDay.order = newDay.getOrder()
        
        save(item: newDay)
        
        loadItems()
        
    }
}
