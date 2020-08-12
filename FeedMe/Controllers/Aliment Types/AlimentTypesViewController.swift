//
//  AlimentTypesViewController.swift
//  FeedMe
//
//  Created by Mathieu Delehaye on 10/08/2020.
//  Copyright © 2020 Mathieu Delehaye. All rights reserved.
//

import UIKit
import RealmSwift

class AlimentTypesViewController: UITableViewController {
    
    let realm = try! Realm()
    
    var alimentTypeArray : Results<AlimentType>?
    
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
           
    func save(item: AlimentType) {
        
        do {
            try realm.write {
                
                realm.add(item)
                
            }
        } catch {
            print("Error saving context \(error)")
        }
        
        loadItems()
    }
            
    func loadItems() {
        
        alimentTypeArray = realm.objects(AlimentType.self).sorted(byKeyPath: "name", ascending: true)
                
        tableView.reloadData()
        
    }
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return alimentTypeArray?.count ?? 0
               
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: K.alimentsCellIdentifier, for: indexPath) as! AlimentsCell
        
        if let alimentType = alimentTypeArray?[indexPath.row] {
            
            cell.titleLabel.text = alimentType.name
            
        }
                
        return cell
        
    }
}
