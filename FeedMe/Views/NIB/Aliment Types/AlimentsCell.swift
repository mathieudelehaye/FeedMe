//
//  AlimentsCell.swift
//  FeedMe
//
//  Created by Mathieu Delehaye on 10/08/2020.
//  Copyright © 2020 Mathieu Delehaye. All rights reserved.
//

import UIKit

class AlimentsCell: UITableViewCell {

    @IBOutlet weak var titleView: UIView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var iconView: UIView!
        
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Round view corners  
        let radiusQuotient = CGFloat(4.5)
        
        titleView.layer.cornerRadius = titleView.frame.size.height /
        radiusQuotient
        
        iconView.layer.cornerRadius = iconView.frame.size.height / radiusQuotient
        
        // Add shadow to views
        let shadowColour = UIColor(rgb: 0xFC8210).cgColor
        let shadowOffset = CGSize(width: 1, height: 1)
        let shadowOpacity = Float(1)
        let shadowRadius = CGFloat(10)
               
        titleView.layer.shadowColor = shadowColour
        titleView.layer.shadowOffset = shadowOffset
        titleView.layer.shadowOpacity = shadowOpacity
        titleView.layer.shadowRadius = shadowRadius
        
        iconView.layer.shadowColor = shadowColour
        iconView.layer.shadowOffset = shadowOffset
        iconView.layer.shadowOpacity = shadowOpacity
        iconView.layer.shadowRadius = shadowRadius
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
