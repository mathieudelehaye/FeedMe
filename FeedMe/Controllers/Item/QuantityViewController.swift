//
//  QuantityViewController.swift
//
//  Created by Mathieu Delehaye on 22/08/2020.
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

class QuantityViewController: ItemViewController {

    @IBOutlet weak var quantitySlider: UISlider!
    
    @IBOutlet weak var quantityLabel: UILabel!
    
    var selectedAliment: Aliment?
    
    var alimentQuantity: Int = 0
    
    var dataUpdated: Bool = false    // true if aliment quantity data has been updated
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // load aliment quantity, update slider and label with it
        guard let aliment = selectedItem as? Aliment else { fatalError("Selected item not of type Aliment") }
        
        selectedAliment = aliment
                
        alimentQuantity = aliment.quantity
        
        quantitySlider.value = Float(alimentQuantity) 
        
        updateLabel()
        
    }
    
    func updateLabel() {
        
        quantityLabel.text = "g: " + String(alimentQuantity)
        
    }
    
    func saveData() {
        
        do {
            try self.realm.write {
                
                selectedAliment!.setValue(alimentQuantity, forKey: "quantity")
                
            }
        } catch {
            print("failed to update \(self.selectedItem?.name ?? "(unknown)") in realm: \(error.localizedDescription)")
        }
        
    }
        
    @IBAction func sliderUsed(_ sender: UISlider, forEvent event: UIEvent) {
        
        if let touchEvent = event.allTouches?.first {
            switch touchEvent.phase {
            case .began:
                print("touch begun for quantity slider")
            case .moved:
                alimentQuantity = Int(floor(sender.value))
               
                updateLabel()
               
                dataUpdated = true  // weight data updated
            case .ended:
                print("touch ended for quantity slider")
            
                // when touch ends, save quantity data
                saveData()
                
                // update calling view
                callingView!.updateView()
                
                // dismiss current view
                dismiss(animated: true, completion: nil)
            
            default:
                break
           }
       }
        
    }
}
