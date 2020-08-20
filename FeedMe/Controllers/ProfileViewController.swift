//
//  ProfileViewController.swift
//  FeedMe
//
//  Created by Mathieu Delehaye on 20/08/2020.
//  Copyright © 2020 Mathieu Delehaye. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet weak var weightSlider: UISlider!
        
    @IBOutlet weak var weightLabel: UILabel!

    var userWeight: Float = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        
    }

    @IBAction func weightChanged(_ sender: UISlider) {
     
        weightLabel.text = "Kg: " + String(Int(floor(userWeight)))
        
    }

}
