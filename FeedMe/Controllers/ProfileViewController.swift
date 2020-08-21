//
//  ProfileViewController.swift
//  FeedMe
//
//  Created by Mathieu Delehaye on 20/08/2020.
//  Copyright © 2020 Mathieu Delehaye. All rights reserved.
//

import UIKit
import RealmSwift

class ProfileViewController: UIViewController {

    @IBOutlet weak var weightSlider: UISlider!
        
    @IBOutlet weak var weightLabel: UILabel!

    let realm = try! Realm()
    
    var userWeight: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // load user weight, update slider and label with it
        let users = realm.objects(User.self)
        
        userWeight = users[0].weight
        
        weightSlider.value = Float(userWeight)
        
        updateLabel()
    }
    
    func updateLabel() {
        
        weightLabel.text = "Kg: " + String(userWeight)
        
    }

    @IBAction func weightChanged(_ sender: UISlider) {
             
        userWeight = Int(floor(sender.value))
        
        updateLabel()
        
    }

}
