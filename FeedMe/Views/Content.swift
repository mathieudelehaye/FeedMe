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
            
            switch (selectedScreen) {
            case 1:
                let _ = print("1 selected")
                LoginView(welcomeCallbacks: welcomeCallbacks)
            case 2:
                let _ = print("2 selected")
                RegisterView(welcomeCallbacks: welcomeCallbacks)
            default:
                WelcomeView(welcomeCallbacks: welcomeCallbacks, selectedScreen: $selectedScreen)
            }
        }
    }
}

struct WelcomeView: View {
    
    var welcomeCallbacks: WelcomeViewController.WelcomeCallbacks
    
    @Binding var selectedScreen: Int8
    
    var body: some View {
        
        ZStack {
            Color("BgOrange")
                .ignoresSafeArea(.all, edges: .all)
            
            VStack(alignment: .center) {
                // Sign in
                Button(action: {
                    selectedScreen = 1
                }) {
                    Text("Login")
                }.font(.largeTitle)
                    .foregroundColor(.white)
                    .padding(.top, 300)
                
                Spacer()
                
                // Sign up
                Button(action: {
                    selectedScreen = 2
                }) {
                    Text("Register")
                }.font(.largeTitle)
                    .foregroundColor(.white)
                    .padding(.bottom, 300)
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

