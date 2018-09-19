//
//  AppDelegate.swift
//  ChoiceTrackerAPP
//
//  Created by Matt Green on 8/16/18.
//  Copyright © 2018 Matt Green. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    //MARK:- Force Portrait
    //set orientations you want to be allowed in this property by default
    var orientationLock = UIInterfaceOrientationMask.all

    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
        return self.orientationLock
    }
    
    
    //MARK:- Properties
    var window: UIWindow?
    let dailyRecordStore = DailyRecordStore()
    let currentDailyRecord = DailyRecord()
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        // access the view controller and set its dailyRecordScore
        let vc = window!.rootViewController as! MainViewController
        vc.dailyRecordStore = dailyRecordStore
        vc.currentDailyRecord = currentDailyRecord
       
        // set theme with ternary operation
        if UserDefaults.standard.object(forKey: "LightTheme") != nil {
            // condition ? [true] : [false]
            Theme.current = UserDefaults.standard.bool(forKey: "LightTheme") ? LightTheme() : DarkTheme()
        }
        
        // set default goal if not defined
        if UserDefaults.standard.object(forKey: "dataLabel") == nil {
            UserDefaults.standard.set("No goal set", forKey: "dataLabel")
        }
        
        return true
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
        
        let success = dailyRecordStore.saveChanges()
        if (success) {
            print("Saved all of the items")
        } else {
            print("could not save any of the items")
        }
    }
}
