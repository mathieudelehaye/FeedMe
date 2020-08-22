//
//  DayCell.swift
//
//  Created by Mathieu Delehaye on 13/07/2020.
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
import CoreImage

protocol CellEdition {
    func showEditionView(forCellAtRow cellRow: Int)
}

class CustomCell: UITableViewCell {
    
    @IBOutlet weak var cellImage: UIImageView!
    @IBOutlet weak var imageSuperView: UIView!
    @IBOutlet weak var colouredView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var macroLabel: UILabel!

    var editor: CellEdition?
    var row: Int?
    
    override func awakeFromNib() {
        super.awakeFromNib()
                  
        // Calculate radius
        let radius = cellImage.frame.size.height / 15
        
        // Round coloured transparent view corners
        let colourViewBounds = colouredView.bounds
        let path = UIBezierPath(roundedRect: colourViewBounds, byRoundingCorners: [.bottomLeft, .bottomRight], cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        colouredView.layer.mask = mask

        // Add shadow to image super view
        imageSuperView.layer.shadowColor = UIColor.black.cgColor
        imageSuperView.layer.shadowOffset = CGSize(width: 0, height: 1)
        imageSuperView.layer.shadowOpacity = 0.25
        imageSuperView.layer.shadowRadius = 4.0
        imageSuperView.clipsToBounds = false
    }
        
    @IBAction func editButtonPressed(_ sender: UIButton) {
    
        print("Edit button pressed")
        
        editor?.showEditionView(forCellAtRow: row!)
        
    }
    
}

