//
//  ChoiceTrackerProSettingsTableView.swift
//  ChoiceTrackerAPP
//
//  Created by Matt Green on 9/2/18.
//  Copyright © 2018 Matt Green. All rights reserved.
//

import UIKit

class ChoiceTrackerProSettingsTableView: UITableViewController {
    //MARK:- Properties
    
    // set by prepareForSegue from SettingsTableView
    // this will be set by "prepareForSegue"
    var dailyRecordStore: DailyRecordStore!
    
    @IBOutlet var monthly: UITableViewCell!
    @IBOutlet var yearly: UITableViewCell!
    @IBOutlet var themes: UITableViewCell!
    @IBOutlet var labelYourData: UITableViewCell!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
         monthly.accessoryType = .disclosureIndicator
         yearly.accessoryType = .disclosureIndicator
         themes.accessoryType = .disclosureIndicator
         labelYourData.accessoryType = .disclosureIndicator
        
        
        
        // set footer to blank to hide extra rows
        tableView.tableFooterView = UIView()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // if we clicked on the "export data" row
        if indexPath.section  == 2 {
            if indexPath.row == 0 {
                // export testing
                //MARK:- Move this to a settings page
                exportCSV(fileName: "testing", data: dailyRecordStore.allDailyRecords, viewController: self)
                print("you pressed export")
            }
        }
    }

}
