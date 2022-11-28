//
//  LoginViewController.swift
//  FeedMe
//
//  Created by Mathieu Delehaye on 27/11/2022.
//  Copyright © 2022 Mathieu Delehaye. All rights reserved.
//

import UIKit
import SwiftUI

class LoginViewController: UIHostingController<LoginView> {
    
    // Class to handle the callback
    class LoginCallbacks {
        var segueCallback: ((String) -> Void)?
    }
 
    required init?(coder: NSCoder) {
        
        let loginCallbacks = LoginCallbacks()
        
        let loginView = LoginView(loginCallbacks: loginCallbacks)
        
        super.init(coder: coder,rootView: loginView);
        
        loginCallbacks.segueCallback = { [weak self] segueName in
            self?.performSegue(withIdentifier: segueName, sender: self)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
