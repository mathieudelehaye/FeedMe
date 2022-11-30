//
//  Login.swift
//  FeedMe
//
//  Created by Mathieu Delehaye on 29/11/2022.
//  Copyright © 2022 Mathieu Delehaye. All rights reserved.
//

import Firebase
import SwiftUI

struct LoginView: View {
        
    var welcomeCallbacks: WelcomeViewController.WelcomeCallbacks
    
    @State private var username: String = ""
    @State private var password: String = ""
        
    var body: some View {
        
        ZStack {
            Color("BgOrange")
                .ignoresSafeArea(.all, edges: .all)
            
            VStack {
                Text("Welcome Back!")
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
                    print("Login tapped")

                    // TODO: move logic to a view controller
                    if username != "" && password != "" {
                        
                        Auth.auth().signIn(withEmail: username, password: password) { authResult, error in
                            
                            if let e = error {
                                print(e)
                            } else {
                                print("Authentication succesfull")
                                
                                // Navigate to the home view
                                welcomeCallbacks.segueCallback?(K.welcomeToDaySegueIdentifier)
                            }
                        }
                    }
                }) {
                    Text("LOGIN")
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

struct Login_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(welcomeCallbacks: WelcomeViewController.WelcomeCallbacks())
    }
}
