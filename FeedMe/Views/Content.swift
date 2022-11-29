//
//  Content.swift
//  FeedMe
//
//  Created by Mathieu Delehaye on 29/11/2022.
//  Copyright © 2022 Mathieu Delehaye. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    var welcomeCallbacks: WelcomeViewController.WelcomeCallbacks
    
    @State private var selectedScreen: Int8 = 0
  
    var body: some View {
        ZStack {
            
            switch (selectedScreen)  {
                case 1:
                    LoginView()

                case 2:
                    LoginView()
                    
                default:
                    WelcomeView(welcomeCallbacks: welcomeCallbacks)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(welcomeCallbacks: WelcomeViewController.WelcomeCallbacks())
            .previewDevice("iPhone X")
    }
}

