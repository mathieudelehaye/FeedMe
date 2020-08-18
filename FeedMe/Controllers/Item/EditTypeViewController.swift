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

    @IBOutlet weak var proValue: UILabel!
        
    @IBOutlet weak var carValue: UILabel!
        
    @IBOutlet weak var fatValue: UILabel!
        
    @IBOutlet weak var calValue: UILabel!
    
    @IBOutlet weak var cancelButton: UIButton!
    
    @IBOutlet weak var confirmButton: UIButton!
    
    @IBOutlet var textField: UITextField!
    
    var newTypeName: String?
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        print("view loaded with EditTypeViewController for item \(selectedItem!.name)")
        
        textField.text = selectedItem?.name
        
        textField.delegate = self
        
        confirmButton.layer.cornerRadius = confirmButton.frame.size.height / 5.5
        
        cancelButton.layer.cornerRadius = confirmButton.frame.size.height / 5.5
        
        newTypeName = ""    // reset new type name when view loaded
    }
        
    @IBAction func confirmButtonPressed(_ sender: UIButton) {
                
        // If new type name not empty, rename the selected item
        if newTypeName! != "" {
            // new type name can be forced unwrapping, as it has been intialized to ""
         
            do {
                try self.realm.write {

                    self.selectedItem?.setValue(newTypeName, forKey: "name")
                    
                    self.selectedItem?.setValue(self.selectedItem?.getOrder(), forKey: "order")

                }
            } catch {
                print("failed to update \(self.selectedItem?.name ?? "(unknown)") in realm: \(error.localizedDescription)")
            }
            
            callingView!.updateView()
            
        }
        
        dismiss(animated: true, completion: nil)    // dismiss view
    }
    
    @IBAction func proSliderChanged(_ sender: UISlider) {
                                
        proValue.text = "Pro. g: " + String(Float(floor(10*sender.value)/10))
        
    }
    
    @IBAction func carSliderChanged(_ sender: UISlider) {
        
        carValue.text = "Car. g: " + String(Float(floor(10*sender.value)/10))
        
    }
            
    @IBAction func fatSliderChanged(_ sender: UISlider) {
    
        fatValue.text = "Fat g: " + String(Float(floor(10*sender.value)/10))
        
    }
        
    @IBAction func calSliderChanged(_ sender: UISlider) {
    
        calValue.text = "KCa.: " + String(Int(sender.value))
        
    }
    
    @IBAction func cancelButtonPressed(_ sender: Any) {
        
        print("cancel button pressed")
        
        dismiss(animated: true, completion: nil)    // dismiss view
        
    }
}

//MARK: - TextField Delegate Methods
extension EditTypeViewController: UITextFieldDelegate {
           
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        
        print("start editing")
        
        let viewHeight = view.bounds.height // view height with modal ratio
        
        let buttonAndScreenBottomDistance = viewHeight - confirmButton.frame.minY - confirmButton.frame.size.height // distance between button and screen bottoms
                
        let keyboardDistance = viewHeight - textField.frame.height - textField.frame.minY - confirmButton.frame.size.height - 2 * buttonAndScreenBottomDistance + 10 // remove text field and button heights
        
        IQKeyboardManager.shared.keyboardDistanceFromTextField = keyboardDistance // change distance between keyboard and text field
        
        return true
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if let enteredText = textField.text {
            
            print("entered value: \(enteredText)")
            
            // Register new type name
            newTypeName = enteredText
            
            textField.resignFirstResponder()    // hide keyboard
                        
        }
        
        return false
        
    }
    
}
