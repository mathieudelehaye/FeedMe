//
//  AlimentTypesViewController.swift
//
//  Created by Mathieu Delehaye on 10/08/2020.
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

class AlimentTypesViewController: ListViewController {
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        tableView.register(UINib(nibName: K.alimentCategoryCellNibName, bundle: nil), forCellReuseIdentifier: K.alimentsCellIdentifier)    // register custom cell to table view
        
        loadItems()        
    }
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Category", message:"", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add", style: .default) { (action) in
          
          let typeName = textField.text!
          
          // Add only the new aliment type if it doesn't already exist in the DB
          if self.realm.objects(AlimentType.self).filter("name == [cd] %@", typeName).count > 0 {
            print(typeName + " aliment type already exists in the database")
            return
          }
        
          let newCategory = AlimentType()
          newCategory.name = typeName
        
          self.save(item: newCategory)
        }
        
        alert.addTextField { (alertTextField) in
            textField.placeholder = "New aliment category"
            textField = alertTextField
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
        
    }
    
    //MARK: - Data Manipulation Methods
       
    override func save(item: AppItem) {
        
        do {
            try realm.write {
                
                realm.add(item)
                
            }
        } catch {
            print("Error saving context \(error)")
        }
        
        loadItems()
    }
            
    override func loadItems() {
        
        let alimentTypeArray = realm.objects(AlimentType.self).sorted(byKeyPath: "name", ascending: true)
        
        itemArray = []
        for alimentType in alimentTypeArray {
            itemArray.append(alimentType)
        }
            
        tableView.reloadData()
        
    }
    
}
    
//MARK: - TableView Data Source Methods
extension AlimentTypesViewController {
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: K.alimentsCellIdentifier, for: indexPath) as! AlimentsCell
    
        let item = itemArray[indexPath.row]
        
        cell.titleLabel.text = item.name

        return cell
                
    }
    
}
    
//MARK: - TableView Delegate Methods
extension AlimentTypesViewController {
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
                
        let storyboard = UIStoryboard(name: "Main", bundle: nil)

        let etvc = storyboard.instantiateViewController(withIdentifier: "EditTypeViewController") as! EditTypeViewController

        let selectedItem = itemArray[indexPath.row]

        etvc.selectedItem = selectedItem

        presentModal(itemNames: remainingItems, forViewController: etvc)
        
    }
        
}

//MARK: - TableView Swipe Actions

extension AlimentTypesViewController {
    
  override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
    
    let deleteAction = UIContextualAction(style: .normal, title: "Delete") { (_, _, completionHandler) in
      
      // Set to false for debugging purpose
      let removeData = true
      
      let selectedItem = self.itemArray[indexPath.row]
      let alimentTypeName = selectedItem.name
      print(alimentTypeName + " type selected for deletion")
        
      // Delete the aliment type
      if removeData {
        do {
          try self.realm.write {
            self.realm.delete(selectedItem)
          }
        } catch {
          print("failed to update \(selectedItem.name) in realm: \(error.localizedDescription)")
        }
      }
                      
      // Delete all the aliments of that type, and remove them from all the meals that use them
      for aliment in self.realm.objects(Aliment.self).filter("name == [cd] %@", alimentTypeName) {
        
        let alimentName = aliment.name

        // Each aliment belongs to only one meal
        let meal = aliment.parentCategory[0] as Meal
        let mealName = meal.name
        
        // Each meal belongs to only one day
        let dayName = meal.parentCategory[0].name
        
        print("  Aliment " + alimentName + " of type " + alimentTypeName + " found from " + mealName + " of " + dayName)
        
        // Delete the aliment
        if removeData {
          do {
            try self.realm.write {
              self.realm.delete(aliment)
            }
          } catch {
            print("failed to update \(aliment.name) in realm: \(error.localizedDescription)")
          }
        }
        
        print("    Removing aliment from the meal list")
                          
        for (index, mealAliment) in meal.aliments.enumerated() {
          let mealAlimentName = mealAliment.name
          
          print("    Aliment " + mealAlimentName + " found from meal " + mealName)
          
          if mealAlimentName == alimentTypeName {
            print("    Aliment deleted from the meal")
            
            // Remove the aliment from the meal list
            if removeData {
              meal.aliments.remove(at: index)
            }
          }
        }
      }

      self.updateView()
     
      completionHandler(true)
    }
    
    deleteAction.image = UIImage(systemName: "trash")
    deleteAction.backgroundColor = UIColor(rgb: 0xFC8210)
    let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
    return configuration
  }
}

//MARK: - ViewController Calling View Management Delegate Methods
extension AlimentTypesViewController {
    
    override func updateView() {

        loadItems()
    }
    
    override func manageViewObject(withName objectName: String) {
        
        // function not used 
        
    }
}
