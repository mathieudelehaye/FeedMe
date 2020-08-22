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
    
    var dataUpdated: Bool = false    // true if user weight data has been updated
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // load user weight, update slider and label with it
        let user = realm.objects(User.self)[0]
                
        userWeight = user.weight
        
        weightSlider.value = Float(userWeight)
        
        updateLabel()
        
        // class is tab bar controller delegate
        tabBarController?.delegate = self
    }
    
    func updateLabel() {
        
        weightLabel.text = "Kg: " + String(userWeight)
        
    }

    @IBAction func weightChanged(_ sender: UISlider) {
             
        userWeight = Int(floor(sender.value))
        
        updateLabel()
        
        dataUpdated = true  // weight data updated
    }

}

//MARK: - Tab bar controller delegate Methods
extension ProfileViewController: UITabBarControllerDelegate {
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        
        if let VCTitle = viewController.title {

//            print(VCTitle)
            if VCTitle != "ProfileNavigation" && dataUpdated {
                
                // Save user data when leaving Profile view if data has been updated
                
                let user = realm.objects(User.self)[0]
                
                do {
                    try self.realm.write {
                        
                        user.setValue(userWeight, forKey: "weight")
                        
                    }
                } catch {
                    print("failed to update user data in realm: \(error.localizedDescription)")
                }
                
                print("user data saved")

            }
        }        
    }
    
}
