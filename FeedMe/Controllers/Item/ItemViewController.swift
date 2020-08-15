//
//  ItemViewController.swift
//  FeedMe
//
//  Created by Mathieu Delehaye on 31/07/2020.
//  Copyright © 2020 Mathieu Delehaye. All rights reserved.
//

import UIKit
import RealmSwift

protocol CallingViewManagement {
    
    func manageViewObject(withName objectName: String)
    
    func updateView()
    
}

extension CallingViewManagement {
    
    func updateView() {
        
        // provide default implementation for protocol method 
    
    }
    
}

class ItemViewController: UIViewController {
    
    var selectedItem : AppItem? // selected item associated with view
    
    var itemNames: [String] = []    // values to replace selected item name
    
    var modalRatio: Float = 0   // ratio of the modal where view is displayed
    
    var callingView: CallingViewManagement?   // calling view
    
    var isCancelled: Bool = false   // true if view has been cancelled

    let realm = try! Realm()

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
    }
}

//MARK: - ViewController Transitioning Delegate Methods
extension EditViewController: UIViewControllerTransitioningDelegate {
        
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        
        if presented is ItemViewController == false {
            fatalError("View Controller type is not derived from ItemViewController.")
        }
        
        let vc = presented as! ItemViewController
        
        let modalRatio = vc.modalRatio
        
        return PartialSizePresentController(presentedViewController: presented, presenting: presenting, withRatio: modalRatio)
        
    }
    
}
