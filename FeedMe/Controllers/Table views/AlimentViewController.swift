//
//  AlimentViewController.swift
//  FeedMe
//
//  Created by Mathieu Delehaye on 09/08/2020.
//  Copyright © 2020 Mathieu Delehaye. All rights reserved.
//

import UIKit
import RealmSwift

class AlimentViewController: ListViewController {
    
    var selectedMeal : Meal?
    
    let fullAlimentList = ["Eggs", "Oat", "Orange", "Almond milk", "Chicken"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UINib(nibName: K.alimentCellNibName, bundle: nil), forCellReuseIdentifier: K.cellIdentifier)    // register custom cell to table view
        
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
        
        title = selectedMeal!.name
        
    }
    
    @IBAction func addAlimentPressed(_ sender: UIBarButtonItem) {
     
        print("Add aliment button pressed")
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)

        let pvc = storyboard.instantiateViewController(withIdentifier: "PickerViewController") as! PickerViewController

        updateRemainingItems(keepingItem: "", fromStartList: fullAlimentList)

        presentModal(itemNames: remainingItems, forViewController: pvc)
        
    }
    
    //MARK: - Data Manipulation Methods
       
    override func save(item: AppItem) {

        do {
            try realm.write {

                if let alimentToSave = item as? Aliment {

                    guard let currentMeal = selectedMeal else { fatalError("Selected meal not available") }

                    currentMeal.aliments.append(alimentToSave)

                    realm.add(alimentToSave)

                }
            }
        } catch {
            print("Error saving context \(error)")
        }

    }

    override func loadItems() {

        if let alimentArray = selectedMeal?.aliments.sorted(byKeyPath: "name", ascending: true) {

            itemArray = []
            for aliment in alimentArray {
                itemArray.append(aliment)
            }

        }

        tableView.reloadData()
    }
}

//MARK: - TableView Data Source Methods

extension AlimentViewController {
    
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
extension AlimentViewController {
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
//        performSegue(withIdentifier: K.MealToAlimentSegueIdentifier, sender: self)
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        print("Aliment selected")
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
//        let destinationVC = segue.destination as! AlimentViewController
//        
//        if let indexPath =  tableView.indexPathForSelectedRow {
//            
//            tableView.deselectRow(at: indexPath, animated: true)
//
//            guard let selectedMeal = itemArray[indexPath.row] as? Meal else { fatalError("Error while retrieving selected item") }
//                
//            destinationVC.selectedMeal = selectedMeal
//            
//        }
    }
        
}

//MARK: - ViewController Cell Edition Delegate Methods
extension AlimentViewController {
        
    override func showEditionView(forCellAtRow cellRow: Int) {
           
        let storyboard = UIStoryboard(name: "Main", bundle: nil)

        let evc = storyboard.instantiateViewController(withIdentifier: "EditViewController") as! EditViewController

        let selectedCellItem = itemArray[cellRow]

        evc.selectedItem = selectedCellItem

        updateRemainingItems(keepingItem: selectedCellItem.name, fromStartList: fullAlimentList)

        presentModal(itemNames: remainingItems, forViewController: evc)
        
    }
    
}

//MARK: - ViewController Calling View Management Delegate Methods
extension AlimentViewController {
    
    override func updateView() {

        loadItems()
    }
    
    override func manageViewObject(withName objectName: String) {
        
        let newAliment = Aliment()
        
        newAliment.name = objectName
        
        newAliment.order = newAliment.getOrder()    // always equal to 0
        
        save(item: newAliment)
        
        loadItems()
        
    }
}
