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
        
        let radiusQuotient = CGFloat(2.7)
        
        titleView.layer.cornerRadius = titleView.frame.size.height /
        radiusQuotient
        
        iconView.layer.cornerRadius = iconView.frame.size.height / radiusQuotient
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
