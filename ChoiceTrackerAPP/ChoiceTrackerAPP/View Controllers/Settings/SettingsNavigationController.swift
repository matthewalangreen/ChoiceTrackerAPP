//
//  SettingsViewController.swift
//  ChoiceTrackerAPP
//
//  Created by Matt Green on 8/17/18.
//  Copyright © 2018 Matt Green. All rights reserved.
//

import UIKit

class SettingsNavigationController: UINavigationController {
    //MARK:- Status bar style
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return UserDefaults.standard.bool(forKey: "LightTheme") ? .default : .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNeedsStatusBarAppearanceUpdate()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
