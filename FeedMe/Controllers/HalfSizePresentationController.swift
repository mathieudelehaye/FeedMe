//
//  HalfSizePresentationController.swift
//  FeedMe
//
//  Created by Mathieu Delehaye on 21/07/2020.
//  Copyright © 2020 Mathieu Delehaye. All rights reserved.
//

import UIKit

class HalfSizePresentationController: UIPresentationController {

    override var frameOfPresentedViewInContainerView: CGRect {
        
        guard let cv = containerView else { fatalError("No container view available") }
        
        return CGRect(x: 0, y: cv.bounds.height/2, width: cv.bounds.width, height: cv.bounds.height/2)
        
    }
    
}
