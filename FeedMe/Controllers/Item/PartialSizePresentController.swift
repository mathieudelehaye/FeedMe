//
//  HalfSizePresentationController.swift
//  FeedMe
//
//  Created by Mathieu Delehaye on 21/07/2020.
//  Copyright © 2020 Mathieu Delehaye. All rights reserved.
//

import UIKit

class PartialSizePresentController: UIPresentationController {
    
    let heightRatio : CGFloat
    
    init(presentedViewController: UIViewController, presenting presentingViewController: UIViewController?, withRatio ratio: Float = 0.5) {
        
        heightRatio = CGFloat(ratio)
        
        super.init(presentedViewController: presentedViewController, presenting: presentingViewController)
        
    }

    override var frameOfPresentedViewInContainerView: CGRect {
        
        guard let cv = containerView else { fatalError("No container view available") }
        
        return CGRect(x: 0, y: cv.bounds.height * (1 - heightRatio), width: cv.bounds.width, height: cv.bounds.height * heightRatio)
        
    }
    
    override func presentationTransitionWillBegin() {
        
        let bdView = UIView(frame: containerView!.bounds)
        
        bdView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        
        containerView?.addSubview(bdView)
        
        bdView.addSubview(presentedView!)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(PartialSizePresentController.handleTap(_:)))
        
        bdView.addGestureRecognizer(tapGesture)
        
    }
    
    override func dismissalTransitionDidEnd(_ completed: Bool) {
        
        // Remove presenting view controller if it is of type EditViewController and if presented view has not been canceled
        let isPresentedViewCancelled = (presentedViewController as! ItemViewController).isCancelled
        
        if presentingViewController is EditViewController && isPresentedViewCancelled == false {
            
            print("we dismiss presenting view controller, as it is of type EditViewController and presented view has not been cancelled")
            
            presentingViewController.dismiss(animated: true, completion: nil)
            
        }
        
    }

    @objc func handleTap(_ sender: UITapGestureRecognizer) {
        
        let itemVC = presentedViewController as! ItemViewController
        
        if let selectedItem = itemVC.selectedItem {
            
            print("tap handled from PartialSizePresentController for item \(selectedItem.name)")
            
        }
        
        itemVC.isCancelled = true   // presented view has been cancelled
        
        itemVC.dismiss(animated: true, completion: nil)

    }
}
