//
//  EditTypeViewController.swift
//  FeedMe
//
//  Created by Mathieu Delehaye on 13/08/2020.
//  Copyright © 2020 Mathieu Delehaye. All rights reserved.
//

import UIKit
import RealmSwift
import IQKeyboardManagerSwift

class EditTypeViewController: ItemViewController {

    @IBOutlet var textField: UITextField!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        print("view loaded with EditTypeViewController for item \(selectedItem!.name)")
        
        textField.text = selectedItem?.name
        
        textField.delegate = self
    }
        
}

//MARK: - TextField Delegate Methods
extension EditTypeViewController: UITextFieldDelegate {
           
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        
        print("start editing")
        
        let viewHeight = view.bounds.height // view height with modal ratio
                
        let keyboardDistance = viewHeight - textField.frame.height - textField.frame.minY
        
        IQKeyboardManager.shared.keyboardDistanceFromTextField = keyboardDistance // change distance between keyboard and text field
        
        return true
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if let enteredText = textField.text {
            
            print("entered value: \(enteredText)")
            
            textField.resignFirstResponder()
            
        }
        
        return false
        
    }
    
}