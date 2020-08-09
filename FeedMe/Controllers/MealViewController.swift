//
//  MealViewController.swift
//  FeedMe
//
//  Created by Mathieu Delehaye on 19/07/2020.
//  Copyright © 2020 Mathieu Delehaye. All rights reserved.
//

import UIKit

class MealViewController: ListViewController, UITableViewDelegate {

    var selectedDay : Day?
        
    let fullMealList = [ "Breakfast", "Lunch", "Dinner", "Snack 1", "Snack 2", "Snack 3" ]
    
    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self // delegate for table view data source
        
        tableView.delegate = self   // delegate for table view events
        
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

//MARK: - ViewController Cell Edition Delegate Methods
extension MealViewController {
    
    override func updateCBView() {
        
        loadItems()
    }
    
    override func manageCBView(withObjectName objectName: String) {
        
        let newMeal = Meal()
        
        newMeal.name = objectName
        
        switch objectName {
        case "Breakfast":
            newMeal.order = 1
        case "Lunch":
            newMeal.order = 2
        case "Dinner":
            newMeal.order = 3
        case "Snack 1":
            newMeal.order = 4
        case "Snack 2":
            newMeal.order = 5
        case "Snack 3":
            newMeal.order = 6
        default:
            newMeal.order = 0
        }
        
        save(item: newMeal)
        
        loadItems()
        
    }
}
