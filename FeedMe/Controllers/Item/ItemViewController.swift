//
//  ItemViewController.swift
//  FeedMe
//
//  Created by Mathieu Delehaye on 31/07/2020.
//  Copyright © 2020 Mathieu Delehaye. All rights reserved.
//

import UIKit
import RealmSwift

protocol CallbackViewManagement {
    
    func manageCBView(withObjectName objectName: String)
    
    func updateCBView()
    
}

extension CallbackViewManagement {
    
    func updateCBView() {
        
        // provide default implementation for protocol method 
    
    }
    
}

class ItemViewController: UIViewController {
    
    var selectedItem : AppItem?
    
    var itemNames: [String] = []
    
    var callbackViewDelegate: CallbackViewManagement?
    
    var isCancelled: Bool = false   // true if view controller has been cancelled 

    let realm = try! Realm()

    override func viewDidLoad() {
        super.viewDidLoad()

    }

}
