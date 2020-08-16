//
//  AlimentTypesViewController.swift
//  FeedMe
//
//  Created by Mathieu Delehaye on 10/08/2020.
//  Copyright © 2020 Mathieu Delehaye. All rights reserved.
//

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
