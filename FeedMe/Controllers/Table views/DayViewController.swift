//
//  DayViewController.swift
//
//  Created by Mathieu Delehaye on 7/7/20.
//
//  FeedMe: An app to track athele fitness diet, fully written in Swift 5 for iOS 13 or later.
//
//  Copyright © 2020 Mathieu Delehaye. All rights reserved.
//
//
//  This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by
//  the Free Software Foundation, either version 3 of the License, or (at your option) any later version.
//
//  This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
//  FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for more details.
//
//  You should have received a copy of the GNU Affero General Public License along with this program. If not, see <https://www.gnu.org/licenses/>.

import UIKit
import RealmSwift 

class DayViewController: ListViewController {
    
    var selectedUser : User?
    
    let fullDayList = [ "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday" ]
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        // Assign user to days view controller
        selectedUser = realm.objects(User.self)[0]
        
        // Register custom cell to table view
        tableView.register(UINib(nibName: K.dayCellNibName, bundle: nil), forCellReuseIdentifier: K.cellIdentifier)
                
        // Read days from realm DB and load table view
        loadItems()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        tableView.reloadData()  // reload table view when appearing to update computed values
        
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
                    
                    guard let currentUser = selectedUser else { fatalError("Selected user not available") }
                                       
                    currentUser.days.append(dayToSave)
                    
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
        
        // Change cell name label
        cell.nameLabel.text = item.name
        
        // Change cell total label
        guard let day = item as? Day else { fatalError("Item is not of type Day") }
                
        guard let user = selectedUser else { fatalError("The user is not defined") }
                
        cell.totalLabel.text = "Day: \(day.calAmount) kCal"
                
        let proSpecific = Float(floor(10*(Float(day.proAmount)/Float(user.weight)))/10)
        
        let fatSpecific = Float(floor(10*(Float(day.fatAmount)/Float(user.weight)))/10)
        
        // Change cell macro label
        cell.macroLabel.text = "Protein g/kg: \(proSpecific), Fat g/kg: \(fatSpecific)"
        
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

//MARK: - ViewController Calling View Management Delegate Methods
extension DayViewController {
    
    override func updateView() {
        
        loadItems()
        
    }
    
    override func manageViewObject(withName objectName: String) {
        
        let newDay = Day()
        
        newDay.name = objectName
        
        newDay.order = newDay.getOrder()
        
        save(item: newDay)
        
        loadItems()
        
    }
}
