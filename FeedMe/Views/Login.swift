//
//  Login.swift
//  FeedMe
//
//  Created by Mathieu Delehaye on 28/11/2022.
//  Copyright © 2022 Mathieu Delehaye. All rights reserved.
//

import SwiftUI

struct LoginView: View {
    
    var loginCallbacks: LoginViewController.LoginCallbacks
    
    var body: some View {
        
        VStack(alignment: .leading) {
            Button(action: {
                loginCallbacks.segueCallback?(K.LoginToDaySegueIdentifier)
            }) {
                Text("Login")
            }.font(.largeTitle)
        }
    }
}

struct Login_Previews: PreviewProvider {
    
    static var previews: some View {
        LoginView(loginCallbacks: LoginViewController.LoginCallbacks()).previewDevice("iPhone X")
    }
}
