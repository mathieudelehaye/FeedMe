//
//  ItemViewController.swift
//
//  Created by Mathieu Delehaye on 31/07/2020.
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
