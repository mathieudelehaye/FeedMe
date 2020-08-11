//
//  SelectViewController.swift
//  FeedMe
//
//  Created by Mathieu Delehaye on 31/07/2020.
//  Copyright © 2020 Mathieu Delehaye. All rights reserved.
//

import UIKit

class PickerViewController: ItemViewController {

    @IBOutlet weak var pickerView: UIPickerView!
    
    private var initialRow = -1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pickerView.dataSource = self    // delegate for component and row numbers
        
        pickerView.delegate = self      // delegate for row titles and selection handling
        
        if initialRow != -1 {

            pickerView.selectRow(initialRow, inComponent: 0, animated: true)    // select initial row

        }
        
        if selectedItem != nil {

            print("view loaded with PickerViewController for item \(selectedItem!.name)")

        }
        
    }
    
    func setInitialRow(forName chosenName: String) {
        
        var index = 0
                
        for name in itemNames {
            
            if chosenName == name {
                
                initialRow = index
                
                break
                
            }
            
            index += 1
            
        }
                
        print("initial row number: \(initialRow)")
    }
    
}
    
//MARK: - PickerView Data Source Methods
extension PickerViewController: UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        
        return 1
        
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
       
        return itemNames.count
        
    }
    
}

//MARK: - PickerView Delegate Methods
extension PickerViewController: UIPickerViewDelegate {
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        
        let attributedString = NSAttributedString(string: itemNames[row], attributes: [NSAttributedString.Key.foregroundColor : UIColor(rgb: 0x007892)])
        
        return attributedString
        
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        let itemName = itemNames[row]
        
        print("\(itemName) selected")
        
        callbackViewDelegate!.manageCBView(withObjectName: itemName)
        
        dismiss(animated: true, completion: nil)
        
    }
    
}
