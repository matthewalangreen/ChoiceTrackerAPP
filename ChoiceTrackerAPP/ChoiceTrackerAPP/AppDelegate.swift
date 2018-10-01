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
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
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
        let success = dailyRecordStore.saveChanges()
        if (success) {
            print("Saved all records")
        } else {
            print("could not save records")
        }
    }
}
