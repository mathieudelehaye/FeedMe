//
//  RegisterView.swift
//  FeedMe
//
//  Created by Mathieu Delehaye on 30/11/2022.
//  Copyright © 2022 Mathieu Delehaye. All rights reserved.
//

import Firebase
import SwiftUI

struct RegisterView: View {
        
    var welcomeCallbacks: WelcomeViewController.WelcomeCallbacks
    
    @State private var username: String = ""
    @State private var password: String = ""
    
    var body: some View {
        
        ZStack {
            Color("BgOrange")
                .ignoresSafeArea(.all, edges: .all)
            
            VStack {
                Text("New User")
                    .font(.largeTitle)
                    .foregroundColor(.white)
                    .fontWeight(.semibold)
                    .padding(.bottom, 20)
                
                TextField("Username", text: $username)
                    .padding()
                    .background(.white)
                    .cornerRadius(5.0)
                    .padding(.bottom, 20)
                
                SecureField("Password", text: $password)
                    .padding()
                    .background(.white)
                    .cornerRadius(5.0)
                    .padding(.bottom, 20)
                        
                Button(action: {
                    print("Create User tapped")
                    
                    // Create the new user
                    // TODO: move logic to a view controller
                    if username != "" && password != "" {
                        
                        Auth.auth().createUser(withEmail: username, password: password) { authResult, error in
                            
                            if let e = error {
                                print(e.localizedDescription)
                            } else {
                                print("User registration succesful")
                                
                                welcomeCallbacks.segueCallback?(K.welcomeToDaySegueIdentifier)
                            }
                        }
                    }
                }) {
                    Text("CREATE")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(width: 220, height: 60)
                        .background(Color("BtnBlue"))
                        .cornerRadius(15.0)
                }
            }
                .padding()
        }
    }
}

struct Register_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView(welcomeCallbacks: WelcomeViewController.WelcomeCallbacks())
    }
}
