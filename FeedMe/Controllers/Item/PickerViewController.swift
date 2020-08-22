//
//  SelectViewController.swift
//
//  Created by Mathieu Delehaye on 31/07/2020.
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
        
        callingView!.manageViewObject(withName: itemName)
        
        dismiss(animated: true, completion: nil)
        
    }
    
}
