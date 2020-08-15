//
//  EditViewController.swift
//  FeedMe
//
//  Created by Mathieu Delehaye on 21/07/2020.
//  Copyright © 2020 Mathieu Delehaye. All rights reserved.
//

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

            }
        } catch {
            print("failed to update \(self.selectedItem?.name ?? "(unknown)") in realm: \(error.localizedDescription)")
        }
        
        callingView!.updateView()    // reload presenting view with item new name 
        
        dismiss(animated: true, completion: nil)
    }

}
