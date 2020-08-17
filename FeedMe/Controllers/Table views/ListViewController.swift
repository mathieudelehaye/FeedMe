//
//  ListViewController.swift
//  FeedMe
//
//  Created by Mathieu Delehaye on 04/08/2020.
//  Copyright © 2020 Mathieu Delehaye. All rights reserved.
//

import UIKit
import RealmSwift

class ListViewController: UITableViewController {
        
    let realm = try! Realm()
    
    var itemArray : [AppItem] = []  // already created items
    
    var remainingItems: [String] = []    //  item name list for picker view
            
    // update item list for picker view by removing already created items without the selected one
    func updateRemainingItems(keepingItem itemName: String = "", fromStartList startList: [String] = []) {
             
        remainingItems = startList
        
        for existingItem in itemArray {
                        
            if itemName != "" && existingItem.name == itemName {

                continue    // if selected name not empty, do not remove it from item list

            }

            if let index = remainingItems.firstIndex(of: existingItem.name) {

                remainingItems.remove(at: index)

            }
            
        }
        
        print("remaining items: \(remainingItems)")
        
    }
    
    func presentModal<T>(itemNames: [String], forViewController presentedViewController: T) {
                   
        if presentedViewController is ItemViewController == false {
            fatalError("View Controller type is not derived from ItemViewController.")
        }
        
        let vc = presentedViewController as! ItemViewController
                
        var modalRatio: Float = 0   // ratio to present view as a modal  
        
        switch T.self {
        case is EditViewController.Type: 
            modalRatio = Float(0.65)    // change modal ratio for edit view
        case is PickerViewController.Type:
            modalRatio = Float(0.36)    // change modal ratio for picker view
        case is EditTypeViewController.Type:
            modalRatio = Float(0.64)     // change modal ratio for edit type view
        default:
            fatalError("View Controller is of an unknown type derived from ItemViewController.")
        }
                                
        vc.modalPresentationStyle = .custom
        
        vc.transitioningDelegate = self
                
        vc.itemNames = itemNames
        
        vc.modalRatio = modalRatio
         
        vc.callingView = self

        self.present(vc, animated: true)
                
    }
        
    //MARK: - Data Manipulation Methods
    func save(item: AppItem) {
                
        fatalError("This method must be overridden")
    }
    
    func loadItems() {
        
        fatalError("This method must be overridden")
        
    }
    
}

//MARK: - TableView Data Source Methods

extension ListViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        fatalError("This method must be overridden")
        
    }
    
}

//MARK: - ViewController Transitioning Delegate Methods
extension ListViewController: UIViewControllerTransitioningDelegate {
        
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
               
        if presented is ItemViewController == false {
            fatalError("View Controller type is not derived from ItemViewController.")
        }
        
        let vc = presented as! ItemViewController
        
        let modalRatio = vc.modalRatio
        
        return PartialSizePresentController(presentedViewController: presented, presenting: presenting, withRatio: modalRatio)
        
    }
    
}

//MARK: - ViewController Cell Edition Delegate Methods
extension ListViewController: CellEdition {
        
    @objc func showEditionView(forCellAtRow cellRow: Int) {
           
        fatalError("This method must be overridden.")
        
    }
    
}

//MARK: - ViewController Calling View Management Delegate Methods
extension ListViewController: CallingViewManagement {
    
    @objc func updateView() {
        
        fatalError("This method must be overridden.")
        
    }
    
    @objc func manageViewObject(withName objectName: String) {
        
        fatalError("This method must be overridden.")
        
    }
}

