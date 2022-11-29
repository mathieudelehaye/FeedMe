//
//  WelcomeViewController.swift
//  FeedMe
//
//  Created by Mathieu Delehaye on 27/11/2022.
//  Copyright © 2022 Mathieu Delehaye. All rights reserved.
//

import UIKit
import SwiftUI

class WelcomeViewController: UIHostingController<ContentView> {
    
    // Class to handle the callback
    class WelcomeCallbacks {
        var segueCallback: ((String) -> Void)?
    }
 
    required init?(coder: NSCoder) {
        
        let welcomeCallbacks = WelcomeCallbacks()
        
        let contentView = ContentView(welcomeCallbacks: welcomeCallbacks)
        
        super.init(coder: coder,rootView: contentView);
        
        welcomeCallbacks.segueCallback = { [weak self] segueName in
            self?.performSegue(withIdentifier: segueName, sender: self)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
