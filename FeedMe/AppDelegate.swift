//
//  AppDelegate.swift
//
//  Created by Mathieu Delehaye on 7/7/20.
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
import RealmSwift
import IQKeyboardManagerSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        print(Realm.Configuration.defaultConfiguration.fileURL)
        
        // create user data if it does not exist
        let realm = try! Realm()
        
        let users = realm.objects(User.self)
                
        if users.count == 0 {
            
            let newUser = User()
            
            newUser.weight = 65
            
            do {
                try realm.write {
                    
                    realm.add(newUser)
                    
                    print("new user created")
                }
            } catch {
                print("Error saving context \(error)")
            }
        }
        
        // activate IQKeyboardManager library 
        IQKeyboardManager.shared.enable = true                      // enable component
        IQKeyboardManager.shared.enableAutoToolbar = false          // keyboard auto tool bar disabled
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true  // keyboard hidden when touched outside text field
        
        return true
    }

    
    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

