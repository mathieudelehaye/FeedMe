//
//  ProfileViewController.swift
//
//  Created by Mathieu Delehaye on 20/08/2020.
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
