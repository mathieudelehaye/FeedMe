//
//  EditTypeViewController.swift
//
//  Created by Mathieu Delehaye on 13/08/2020.
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
import IQKeyboardManagerSwift

class EditTypeViewController: ItemViewController {

    @IBOutlet weak var proSlider: UISlider!
    @IBOutlet weak var proValue: UILabel!
    
    @IBOutlet weak var carSlider: UISlider!
    @IBOutlet weak var carValue: UILabel!
    
    @IBOutlet weak var fatSlider: UISlider!
    @IBOutlet weak var fatValue: UILabel!
       
    @IBOutlet weak var calSlider: UISlider!
    @IBOutlet weak var calValue: UILabel!
    
    @IBOutlet weak var cancelButton: UIButton!
    
    @IBOutlet weak var confirmButton: UIButton!
    
    @IBOutlet var textField: UITextField!
    
    // new aliment type name for renaming 
    var newTypeName: String?
    
    // variables to store aliment type macros
    var proMacro = Macro(type: .protein)
    
    var carMacro = Macro(type: .carbohydrate)
    
    var fatMacro = Macro(type: .fat)
    
    var calMacro = Macro(type: .energy)
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        print("view loaded with EditTypeViewController for item \(selectedItem!.name)")
        
        // set up text field
        textField.text = selectedItem?.name
        
        textField.delegate = self
        
        // round button corners
        confirmButton.layer.cornerRadius = confirmButton.frame.size.height / 5.5
        
        cancelButton.layer.cornerRadius = confirmButton.frame.size.height / 5.5
        
        // reset new type name
        newTypeName = ""
        
        // set macro variables, sliders and labels according to selected item
        guard let item = selectedItem as? AlimentType else { fatalError("Selected item not of type AlimentType.") }
        
        proMacro.value = item.proSpecific
        proSlider.value = proMacro.value
        updateLabel(forMacro: .protein)
        
        carMacro.value = item.carSpecific
        carSlider.value = carMacro.value
        updateLabel(forMacro: .carbohydrate)
        
        fatMacro.value = item.fatSpecific
        fatSlider.value = fatMacro.value
        updateLabel(forMacro: .fat)
        
        calMacro.value = item.calSpecific
        calSlider.value = calMacro.value
        updateLabel(forMacro: .energy)
        
    }
    
    func updateLabel(forMacro macro: MacroType) {
        
        switch macro {
        case .protein:
            proValue.text = "Pro. g: " + String(proMacro.value)
        case .carbohydrate:
            carValue.text = "Car. g: " + String(carMacro.value)
        case .fat:
            fatValue.text = "Fat g: " + String(fatMacro.value)
        case .energy:
            calValue.text = "KCa.: " + String(calMacro.getValueInt())
        default:
            print("default not handled")
        }
        
    }
        
    @IBAction func proSliderChanged(_ sender: UISlider) {
              
        proMacro.value = sender.value
        updateLabel(forMacro: .protein)
        
    }
    
    @IBAction func carSliderChanged(_ sender: UISlider) {
        
        carMacro.value = sender.value
        updateLabel(forMacro: .carbohydrate)
        
    }
            
    @IBAction func fatSliderChanged(_ sender: UISlider) {
    
        fatMacro.value = sender.value
        updateLabel(forMacro: .fat)
        
    }
        
    @IBAction func calSliderChanged(_ sender: UISlider) {
    
        calMacro.value = sender.value
        updateLabel(forMacro: .energy)
        
    }
    
    @IBAction func cancelButtonPressed(_ sender: Any) {
        
        print("cancel button pressed")
        
        dismiss(animated: true, completion: nil)    // dismiss view
        
    }
    
    @IBAction func confirmButtonPressed(_ sender: UIButton) {
        
        do {
            try self.realm.write {
                
                guard let item = selectedItem as? AlimentType else { fatalError("Selected item not of type AlimentType.") }
                
                // If new type name not empty, rename the selected item
                if newTypeName! != "" {
                    // new type name can be forced unwrapping, as it has been intialized to ""
                    item.setValue(newTypeName, forKey: "name")
                }
                
                item.setValue(proMacro.value, forKey: "proSpecific")
                
                item.setValue(carMacro.value, forKey: "carSpecific")
                
                item.setValue(fatMacro.value, forKey: "fatSpecific")
                
                item.setValue(calMacro.value, forKey: "calSpecific")
                
            }
        } catch {
            print("failed to update \(self.selectedItem?.name ?? "(unknown)") in realm: \(error.localizedDescription)")
        }
        
        callingView!.updateView()
        
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
