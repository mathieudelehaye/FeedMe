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
        
        loadMeals()  // read meals from realm DB and load table view
    }
    
    @IBAction func addMealPressed(_ sender: UIBarButtonItem) {
     
        print("Add meal button pressed")
        
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//
//        let pvc = storyboard.instantiateViewController(withIdentifier: "PickerViewController") as! PickerViewController
//
//        updateRemainingItems(keepingItem: "", fromStartList: [ "Breakfast", "Lunch", "Dinner", "Snack 1", "Snack 2", "Snack 3" ])
        
//        presentModal(itemNames: remainingItems, forViewController: pvc)
        
    }
    
    //MARK: - Data Manipulation Methods
       
    func loadMeals() {

        let mealArray = realm.objects(Meal.self)
        
        itemArray = []
        for meal in mealArray {
            itemArray.append(meal)
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
        
        updateRemainingItems(keepingItem: selectedCellItem.name, fromStartList: [ "Breakfast", "Dinner", "Supper" ])
        
        presentModal(itemNames: remainingItems, forViewController: evc)
        
    }
    
}

//MARK: - ViewController Cell Edition Delegate Methods
extension MealViewController {
    
    override func updateCBView() {
        
        loadMeals()
    }
    
    override func manageCBView(withObjectName objectName: String) {
        
        let newDay = Day()
        
        newDay.name = objectName
        
        save(item: newDay)
        
        loadMeals()
        
    }
}
