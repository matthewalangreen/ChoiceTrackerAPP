//
//  ThemeProtocol.swift
//  ChoiceTrackerAPP
//
//  Created by Matt Green on 9/15/18.
//  Copyright © 2018 Matt Green. All rights reserved.
//

import UIKit

protocol ThemeProtocol {
    var goodColor: UIColor { get }
    var badColor: UIColor { get }
    var headerColor: UIColor { get }
    var backgroundColor: UIColor { get }
    var textColor: UIColor { get }
    var historyCellTextColor: UIColor { get }
    var logoImage: String { get }
    var buttonTintColor: UIColor { get }
    var tableHeaderColor: UIColor { get }
}
