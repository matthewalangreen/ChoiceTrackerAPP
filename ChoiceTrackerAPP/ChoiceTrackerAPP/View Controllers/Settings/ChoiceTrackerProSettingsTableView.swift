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
    
    @IBOutlet var ThemeSwitchOutlet: UISwitch!
    @IBAction func ThemeSwitch(_ sender: UISwitch) {
        Theme.current = sender.isOn ? LightTheme() : DarkTheme()
        UserDefaults.standard.set(sender.isOn, forKey: "LightTheme")
    }
    
    
    // set by prepareForSegue from SettingsTableView
    // this will be set by "prepareForSegue"
    var dailyRecordStore: DailyRecordStore!
    
    @IBOutlet var monthly: UITableViewCell!
    @IBOutlet var yearly: UITableViewCell!
    @IBOutlet var themes: UITableViewCell!
    @IBOutlet var labelYourData: UITableViewCell!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // if never set user default theme
        if UserDefaults.standard.object(forKey: "LightTheme") == nil {
            UserDefaults.standard.set(true, forKey: "LightTheme")
        }
        
       // set theme
        ThemeSwitchOutlet.isOn = UserDefaults.standard.bool(forKey: "LightTheme")
        
         monthly.accessoryType = .disclosureIndicator
         yearly.accessoryType = .disclosureIndicator
         //themes.accessoryType = .disclosureIndicator
         labelYourData.accessoryType = .disclosureIndicator
  
        // set footer to blank to hide extra rows
        tableView.tableFooterView = UIView()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // if we clicked on the "export data" row
        if indexPath.section  == 2 {
            if indexPath.row == 0 {
                //MARK:- Data Export
                let nowString = exportFileNameDateFormatter.string(from: Date())
                exportCSV(fileName: nowString, data: dailyRecordStore.allDailyRecords, viewController: self)
                print("you pressed export")
            }
        }
    }
    
    //MARK:- Force Portrait
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        AppUtility.lockOrientation(.portrait)
        // Or to rotate and lock
        // AppUtility.lockOrientation(.portrait, andRotateTo: .portrait)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Don't forget to reset when view is being removed
        AppUtility.lockOrientation(.all)
    }

}
