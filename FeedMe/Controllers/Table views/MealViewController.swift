//
//  MealViewController.swift
//
//  Created by Mathieu Delehaye on 19/07/2020.
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

class MealViewController: ListViewController {

    var selectedDay : Day?
        
    let fullMealList = [ "Breakfast", "Lunch", "Dinner", "Snack 1", "Snack 2", "Snack 3" ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UINib(nibName: K.mealCellNibName, bundle: nil), forCellReuseIdentifier: K.cellIdentifier)    // register custom cell to table view
        
        // Change navigation bar back button image to custom one 
        let backButtonBackgroundImage = UIImage(named: "back_bar_button")
        navigationController?.navigationBar.backIndicatorImage = backButtonBackgroundImage
        navigationController?.navigationBar.backIndicatorTransitionMaskImage = backButtonBackgroundImage
        
        // Remove navigation bar back button title:
        let backBarButton = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationController?.navigationBar.topItem?.backBarButtonItem = backBarButton
        
        loadItems()  // read meals from realm DB and load table view
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        title = selectedDay!.name
        
    }
    
    @IBAction func addMealPressed(_ sender: UIBarButtonItem) {
     
        print("Add meal button pressed")
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)

        let pvc = storyboard.instantiateViewController(withIdentifier: "PickerViewController") as! PickerViewController

        updateRemainingItems(keepingItem: "", fromStartList: fullMealList)
        
        presentModal(itemNames: remainingItems, forViewController: pvc)
        
    }
    
    //MARK: - Data Manipulation Methods
       
    override func save(item: AppItem) {
        
        do {
            try realm.write {
                
                if let mealToSave = item as? Meal {
                                        
                    guard let currentDay = selectedDay else { fatalError("Selected day not available") }
                    
                    currentDay.meals.append(mealToSave)
                    
                    realm.add(mealToSave)
                    
                }
            }
        } catch {
            print("Error saving context \(error)")
        }
        
    }
    
    override func loadItems() {

        if let mealArray = selectedDay?.meals.sorted(byKeyPath: "order", ascending: true) {
            
            itemArray = []
            for meal in mealArray {
                itemArray.append(meal)
            }
            
        }
        
        tableView.reloadData()
    }
}

//MARK: - TableView Data Source Methods

extension MealViewController {
    
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
extension MealViewController {
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: K.MealToAlimentSegueIdentifier, sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let destinationVC = segue.destination as! AlimentViewController
        
        if let indexPath =  tableView.indexPathForSelectedRow {
            
            tableView.deselectRow(at: indexPath, animated: true)

            guard let selectedMeal = itemArray[indexPath.row] as? Meal else { fatalError("Error while retrieving selected item") }
                
            destinationVC.selectedMeal = selectedMeal
            
        }
    }
        
}

//MARK: - ViewController Cell Edition Delegate Methods
extension MealViewController {
        
    override func showEditionView(forCellAtRow cellRow: Int) {
           
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let evc = storyboard.instantiateViewController(withIdentifier: "EditViewController") as! EditViewController
        
        let selectedCellItem = itemArray[cellRow]
        
        evc.selectedItem = selectedCellItem
        
        updateRemainingItems(keepingItem: selectedCellItem.name, fromStartList: fullMealList)
        
        presentModal(itemNames: remainingItems, forViewController: evc)
        
    }
    
}

//MARK: - ViewController Calling View Management Delegate Methods
extension MealViewController {
    
    override func updateView() {
        
        loadItems()
    }
    
    override func manageViewObject(withName objectName: String) {
        
        let newMeal = Meal()
        
        newMeal.name = objectName
        
        newMeal.order = newMeal.getOrder()
        
        save(item: newMeal)
        
        loadItems()
        
    }
}
