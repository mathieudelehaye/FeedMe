//
//  EditViewController.swift
//  FeedMe
//
//  Created by Mathieu Delehaye on 21/07/2020.
//  Copyright © 2020 Mathieu Delehaye. All rights reserved.
//

import UIKit
import RealmSwift

protocol CallbackViewManagement {
    func updateCBView()
}

class EditViewController: UIViewController {
    
    var selectedItem : AppItem?
//    var callbackViewDelegate: CallbackViewManagement?

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        print("view loaded with EditViewController for item \(selectedItem!.name)")
         
    }
    
    @IBAction func cancelPressed(_ sender: UIButton) {
        print("button pressed from EditViewController for item \(selectedItem!.name)")

        dismiss(animated: true, completion: nil)
        
    }
    
//    //MARK: - TableView Delegate Methods
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//
//        switch indexPath.row {
//            case 0:
//                print("Rename selected")
//
//                tableView.deselectRow(at: indexPath, animated: true)
//
//                var textField = UITextField()
//
//                let alert = UIAlertController(title: "Enter New Name", message:"", preferredStyle: .alert)
//
//                let action = UIAlertAction(title: "Rename", style: .default) { (action) in
//
//                    let newName = textField.text!
//
//                    do {
//                        try self.realm.write {
//
//                            self.selectedItem?.setValue(newName, forKey: "name")
//
//                        }
//                    } catch {
//                        print("failed to update \(self.selectedItem?.name ?? "(unknown)") in realm: \(error.localizedDescription)")
//                    }
//
//                    self.callbackViewDelegate!.updateCBView()
//
//                    self.dismiss(animated: true, completion: nil)
//
//                }
//
//                alert.addTextField { (alertTextField) in
//                    textField.placeholder = "Rename item"
//                    textField = alertTextField
//                }
//
//                alert.addAction(action)
//
//                present(alert, animated: true, completion: nil)
//
//            case 1:
//                print("Delete selected")
//
//                tableView.deselectRow(at: indexPath, animated: true)
//
//                do {
//                    try self.realm.write {
//                        self.realm.delete(selectedItem!)
//                    }
//                } catch {
//                    print("error while deleting item, \(error)")
//                }
//
//                callbackViewDelegate!.updateCBView()
//
//                dismiss(animated: true, completion: nil)
//
//            case 2:
//                print("Cancel selected")
//                dismiss(animated: true, completion: nil)
//            default:
//                print("Default selected")
//        }
//    }
    
}
