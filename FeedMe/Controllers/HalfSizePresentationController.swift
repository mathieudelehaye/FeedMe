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
    
    override func presentationTransitionWillBegin() {
        
        let bdView = UIView(frame: containerView!.bounds)
        
        bdView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        
        containerView?.addSubview(bdView)
        
        bdView.addSubview(presentedView!)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(HalfSizePresentationController.handleTap(_:)))
        
        bdView.addGestureRecognizer(tapGesture)
        
    }

    @objc func handleTap(_ sender: UITapGestureRecognizer) {
        let itemEditVC = presentedViewController as! EditViewController
        
        print("tap handled from HalfSizePresentationController for item \(itemEditVC.selectedItem!.name)")
        
        presentedViewController.dismiss(animated: true, completion: nil)
    }
}
