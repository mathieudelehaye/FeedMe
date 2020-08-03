//
//  DayCell.swift
//  FeedMe
//
//  Created by Mathieu Delehaye on 13/07/2020.
//  Copyright © 2020 Mathieu Delehaye. All rights reserved.
//

import UIKit
import CoreImage

protocol CellEdition {
    func showEditionView(forCellAtRow cellRow: Int)
}

class DayCell: UITableViewCell {
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var dayImage: UIImageView!
    @IBOutlet weak var imageSuperView: UIView!
    @IBOutlet weak var colouredView: UIView!
    @IBOutlet weak var dayNameLabel: UILabel!
    
    var editor: CellEdition?
    var row: Int?
    
    override func awakeFromNib() {
        super.awakeFromNib()
                  
        // Calculate radius
        let radius = dayImage.frame.size.height / 15
        
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
    
//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//
//        print("DayCell.setSelected: selected status = \(selected)")
//        
//        // Configure the view for the selected state
//    }
}

