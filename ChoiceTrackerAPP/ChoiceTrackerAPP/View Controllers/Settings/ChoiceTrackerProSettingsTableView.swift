//
//  ChoiceTrackerProSettingsTableView.swift
//  ChoiceTrackerAPP
//
//  Created by Matt Green on 9/2/18.
//  Copyright © 2018 Matt Green. All rights reserved.
//

import UIKit

class ChoiceTrackerProSettingsTableView: UITableViewController {
    //MARK:- Outlets to cells
    @IBOutlet var infoCell: SettingsInfoCell!
    @IBOutlet var monthly: UITableViewCell!
    @IBOutlet var yearly: UITableViewCell!
    @IBOutlet var themes: UITableViewCell!
    @IBOutlet var labelYourData: UITableViewCell!
    @IBOutlet var exportDataCell: UITableViewCell!
    
    //MARK:- Outlets to cell labels
    @IBOutlet var HeaderTextView: UITextView!
    @IBOutlet var MonthlyLabel: UILabel!
    @IBOutlet var YearlyLabel: UILabel!
    @IBOutlet var ThemeLabel: UILabel!
    @IBOutlet var LabelYourDataLabel: UILabel!
    @IBOutlet var ExportDataLabel: UILabel!
    
    //MARK:- Properties
    
    @IBOutlet var ThemeSwitchOutlet: UISwitch!
    fileprivate func ApplyTheme() {
        // apply bar color theme
        let navBar = self.navigationController?.navigationBar
        // change the bar tint color to change what the color of the bar itself looks like
        navBar?.barTintColor = Theme.current.headerColor
        // back button
        navBar?.tintColor = Theme.current.textColor
        navBar?.isTranslucent = false
        //  title color
        navBar?.titleTextAttributes = [NSAttributedStringKey.foregroundColor: Theme.current.textColor]
        
        infoCell.backgroundColor = Theme.current.backgroundColor
        monthly.backgroundColor = Theme.current.backgroundColor
        yearly.backgroundColor = Theme.current.backgroundColor
        themes.backgroundColor = Theme.current.backgroundColor
        labelYourData.backgroundColor = Theme.current.backgroundColor
        exportDataCell.backgroundColor = Theme.current.backgroundColor
        view.backgroundColor = Theme.current.backgroundColor
        HeaderTextView.backgroundColor = Theme.current.backgroundColor
        HeaderTextView.textColor = Theme.current.textColor
        MonthlyLabel.textColor = Theme.current.textColor
        YearlyLabel.textColor = Theme.current.textColor
        ThemeLabel.textColor = Theme.current.textColor
        LabelYourDataLabel.textColor = Theme.current.textColor
        ExportDataLabel.textColor = Theme.current.textColor
        
    }
    
    @IBAction func ThemeSwitch(_ sender: UISwitch) {
        Theme.current = sender.isOn ? LightTheme() : DarkTheme()
        UserDefaults.standard.set(sender.isOn, forKey: "LightTheme")
       
        // set the status bar style based on which theme we are using
        UIApplication.shared.statusBarStyle = UserDefaults.standard.bool(forKey: "LightTheme") ? .default : .lightContent
        
        ApplyTheme()
        
        view.setNeedsDisplay()
    }
    
    
    // set by prepareForSegue from SettingsTableView
    // this will be set by "prepareForSegue"
    var dailyRecordStore: DailyRecordStore!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       ApplyTheme()

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
            if indexPath.row == 2 {
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
        
       ApplyTheme()
        
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
