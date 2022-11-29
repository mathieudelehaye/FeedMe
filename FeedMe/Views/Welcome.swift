//
//  Welcome.swift
//  FeedMe
//
//  Created by Mathieu Delehaye on 28/11/2022.
//  Copyright © 2022 Mathieu Delehaye. All rights reserved.
//

import SwiftUI

struct WelcomeView: View {
    
    var welcomeCallbacks: WelcomeViewController.WelcomeCallbacks
    
    var body: some View {
        
        ZStack {
            Color("BgOrange")
                .ignoresSafeArea(.all, edges: .all)
            
            VStack(alignment: .center) {
                // Sign in
                Button(action: {
                    welcomeCallbacks.segueCallback?(K.welcomeToDaySegueIdentifier)
                }) {
                    Text("Register")
                }.font(.largeTitle)
                    .foregroundColor(.white)
                    .padding(.top, 300)
                
                Spacer()
                
                // Sign up
                Button(action: {
                    welcomeCallbacks.segueCallback?(K.welcomeToDaySegueIdentifier)
                }) {
                    Text("Welcome")
                }.font(.largeTitle)
                    .foregroundColor(.white)
                    .padding(.bottom, 300)
            }
        }
    }
}

struct Welcome_Previews: PreviewProvider {
    
    static var previews: some View {
        WelcomeView(welcomeCallbacks: WelcomeViewController.WelcomeCallbacks()).previewDevice("iPhone X")
    }
}
