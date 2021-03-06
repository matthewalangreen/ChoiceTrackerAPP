//
//  DarkTheme.swift
//  ChoiceTrackerAPP
//
//  Created by Matt Green on 9/15/18.
//  Copyright © 2018 Matt Green. All rights reserved.
//

import UIKit

class DarkTheme: ThemeProtocol {
    var goodColor: UIColor = UIColor(named: "light-good")!
    var badColor: UIColor = UIColor(named: "light-bad")!
    var headerColor: UIColor = UIColor(named: "dark-background")!
    var backgroundColor: UIColor = UIColor(named: "dark-background")!
    var textColor: UIColor = UIColor.white
    var historyCellTextColor: UIColor = UIColor.white
    var logoImage: String = "logo-dark"
    var buttonTintColor: UIColor = UIColor.white
    var tableHeaderColor: UIColor = UIColor(named: "dark-background-header")!
}
