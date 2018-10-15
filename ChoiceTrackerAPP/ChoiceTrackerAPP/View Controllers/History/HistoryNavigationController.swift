//
//  HistoryNavigationController.swift
//  ChoiceTrackerAPP
//
//  Created by Matt Green on 8/18/18.
//  Copyright © 2018 Matt Green. All rights reserved.
//

import UIKit

class HistoryNavigationController: UINavigationController {
    //MARK:- Status bar style
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return UserDefaults.standard.bool(forKey: "LightTheme") ? .lightContent : .default
    }

}

