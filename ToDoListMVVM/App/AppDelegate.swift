//
//  AppDelegate.swift
//  ToDoListMVVM
//
//  Created by Sevban Kocabas on 28.02.2020.
//  Copyright © 2020 Sevban Kocabas. All rights reserved.
//

import UIKit
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        FirebaseApp.configure()
        app.router.start()
        
        return true
    }
    


}

