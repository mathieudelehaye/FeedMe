//
//  EditViewController.swift
//
//  Created by Mathieu Delehaye on 21/07/2020.
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

class EditViewController: ItemViewController {
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        print("view loaded with EditViewController for item \(selectedItem!.name)")
         
    }
    
    @IBAction func renamePressed(_ sender: UIButton) {
        
        print("rename button pressed from EditViewController for item \(selectedItem!.name)")
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
                       
        let pvc = storyboard.instantiateViewController(withIdentifier: "PickerViewController") as! PickerViewController
       
        pvc.modalPresentationStyle = .custom
       
        pvc.transitioningDelegate = self
       
        pvc.itemNames = itemNames
        
        pvc.setInitialRow(forName: selectedItem!.name)
        
        pvc.selectedItem = selectedItem

        pvc.callingView = self
                
        pvc.modalRatio = Float(0.36)    // ratio to present view as a modal
        
        self.present(pvc, animated: true)
        
    }
    
    @IBAction func deletePressed(_ sender: UIButton) {
    
        print("delete button pressed from EditViewController for item \(selectedItem!.name)")
        
        do {
            try self.realm.write {
                self.realm.delete(selectedItem!)
            }
        } catch {
            print("error while deleting item, \(error)")
        }

        callingView!.updateView()

        dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func cancelPressed(_ sender: UIButton) {
        
        print("cancel button pressed from EditViewController for item \(selectedItem!.name)")
        
        isCancelled = true   // view has been cancelled

        dismiss(animated: true, completion: nil)
        
    }
    
}

//MARK: - ViewController Cell Edition Delegate Methods
extension EditViewController: CallingViewManagement {
           
    func manageViewObject(withName objectName: String) {
        
        // Rename selected object
        do {
            try self.realm.write {

                self.selectedItem?.setValue(objectName, forKey: "name")
                
                self.selectedItem?.setValue(self.selectedItem?.getOrder(), forKey: "order")
                
                // For Aliment item edition, picked AlimentType must be associated
                if self.selectedItem is Aliment {
                    
                    let selectedAliment = self.selectedItem as! Aliment
                    
                    let pickedAlimentType = realm.objects(AlimentType.self).filter("name CONTAINS [cd] %@", objectName)[0]
                    
                    selectedAliment.type = pickedAlimentType
                }
            }
        } catch {
            print("failed to update \(self.selectedItem?.name ?? "(unknown)") in realm: \(error.localizedDescription)")
        }
        
        callingView!.updateView()    // reload presenting view with item new name 
        
        dismiss(animated: true, completion: nil)
    }

}
