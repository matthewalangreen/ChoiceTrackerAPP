//
//  ChoiceTrackerProSettingsTableView.swift
//  ChoiceTrackerAPP
//
//  Created by Matt Green on 9/2/18.
//  Copyright © 2018 Matt Green. All rights reserved.
//

import UIKit

class ChoiceTrackerProSettingsTableView: UITableViewController {
    @IBOutlet var monthly: UITableViewCell!
    @IBOutlet var yearly: UITableViewCell!
    @IBOutlet var exportData: UITableViewCell!
    @IBOutlet var themes: UITableViewCell!
    @IBOutlet var labelYourData: UITableViewCell!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
         monthly.accessoryType = .disclosureIndicator
         yearly.accessoryType = .disclosureIndicator
         exportData.accessoryType = .disclosureIndicator
         themes.accessoryType = .disclosureIndicator
         labelYourData.accessoryType = .disclosureIndicator
        
        
        
        // set footer to blank to hide extra rows
        tableView.tableFooterView = UIView()
    }

}
