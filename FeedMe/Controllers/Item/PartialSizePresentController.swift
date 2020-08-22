//
//  HalfSizePresentationController.swift
//
//  Created by Mathieu Delehaye on 21/07/2020.
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
