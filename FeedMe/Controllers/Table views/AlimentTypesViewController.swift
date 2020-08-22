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
            
            let newCategory = AlimentType()
            newCategory.name = textField.text!
            
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

//MARK: - ViewController Calling View Management Delegate Methods
extension AlimentTypesViewController {
    
    override func updateView() {

        loadItems()
    }
    
    override func manageViewObject(withName objectName: String) {
        
        // function not used 
        
    }
}
