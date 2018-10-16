//
//  ChoiceTrackerProSettingsTableView.swift
//  ChoiceTrackerAPP
//
//  Created by Matt Green on 9/2/18.
//  Copyright © 2018 Matt Green. All rights reserved.
//

import UIKit

class ChoiceTrackerProSettingsTableView: UITableViewController {
    //MARK:- Status bar style
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return UserDefaults.standard.bool(forKey: "LightTheme") ? .lightContent : .default
    }
    
    func adjustUITextViewHeight(arg : UITextView)
    {
        arg.translatesAutoresizingMaskIntoConstraints = true
        arg.sizeToFit()
        arg.isScrollEnabled = false
    }
    
    var userDataLabelField: UITextField?
    
    //MARK:- Outlets to cells
    @IBOutlet var infoCell: UITableViewCell!
    @IBOutlet var monthly: UITableViewCell!
    @IBOutlet var yearly: UITableViewCell!
    @IBOutlet var themes: UITableViewCell!
    @IBOutlet var labelYourData: UITableViewCell!
    @IBOutlet var exportDataCell: UITableViewCell!
    
    //MARK:- Outlets to cell labels
    @IBOutlet var HeaderTextLabel: UILabel!
    @IBOutlet var MonthlyLabel: UILabel!
    @IBOutlet var YearlyLabel: UILabel!
    @IBOutlet var ThemeLabel: UILabel!
    @IBOutlet var LabelYourDataLabel: UILabel!
    @IBOutlet var ExportDataLabel: UILabel!
    @IBOutlet var currentDataLabel: UILabel!
    
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
        navBar?.titleTextAttributes = [NSAttributedString.Key.foregroundColor: Theme.current.textColor]
        
        infoCell.backgroundColor = Theme.current.backgroundColor
        monthly.backgroundColor = Theme.current.backgroundColor
        yearly.backgroundColor = Theme.current.backgroundColor
        themes.backgroundColor = Theme.current.backgroundColor
        labelYourData.backgroundColor = Theme.current.backgroundColor
        exportDataCell.backgroundColor = Theme.current.backgroundColor
        view.backgroundColor = Theme.current.backgroundColor
        HeaderTextLabel.backgroundColor = Theme.current.backgroundColor
        HeaderTextLabel.textColor = Theme.current.textColor
        MonthlyLabel.textColor = Theme.current.textColor
        YearlyLabel.textColor = Theme.current.textColor
        ThemeLabel.textColor = Theme.current.textColor
        LabelYourDataLabel.textColor = Theme.current.textColor
        ExportDataLabel.textColor = Theme.current.textColor
    }
    
    @IBAction func ThemeSwitch(_ sender: UISwitch) {
        Theme.current = sender.isOn ? DarkTheme() : LightTheme()
        UserDefaults.standard.set(sender.isOn, forKey: "LightTheme")
       
        // set the status bar style based on which theme we are using
        // deprecated in ios 9. Did this:
        // https://stackoverflow.com/questions/52238121/how-to-change-status-bar-style-ios-12
        // UIApplication.shared.statusBarStyle = UserDefaults.standard.bool(forKey: "LightTheme") ? .default : .lightContent
        
        
        ApplyTheme()
        
        DispatchQueue.main.async { self.tableView.reloadData() }
        view.setNeedsDisplay()
        setNeedsStatusBarAppearanceUpdate()
        
    }
    
    
    // set by prepareForSegue from SettingsTableView
    // this will be set by "prepareForSegue"
    var dailyRecordStore: DailyRecordStore!
    var currentDailyRecord: DailyRecord!
    
  
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //adjustUITextViewHeight(arg: HeaderTextView)
   
        ApplyTheme()

        // if never set user default theme
        if UserDefaults.standard.object(forKey: "LightTheme") == nil {
            UserDefaults.standard.set(false, forKey: "LightTheme")
        }
        
        // if never set user default label
        if UserDefaults.standard.object(forKey: "dataLabel") == nil {
            UserDefaults.standard.set("Default Data Label", forKey: "dataLabel")
        }
   
        // set theme
        ThemeSwitchOutlet.isOn = UserDefaults.standard.bool(forKey: "LightTheme")
        
        // set label
        let goalText = UserDefaults.standard.string(forKey: "dataLabel")
        userDataLabelField?.text = goalText
        currentDataLabel.text = goalText
        
        monthly.accessoryType = .disclosureIndicator
        yearly.accessoryType = .disclosureIndicator

        // set footer to blank to hide extra rows
        tableView.tableFooterView = UIView()
        
        setNeedsStatusBarAppearanceUpdate()
    }
    
    //MARK:- OVERRIDE
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section  == 2 {
            //MARK:- Change Goal
            if indexPath.row == 1 {
                let alert: UIAlertController = changeGoalAlertWithHandler(currentDailyRecord: currentDailyRecord, handler: {
                    self.currentDataLabel.text = UserDefaults.standard.string(forKey: "dataLabel")
                    let indexPath = NSIndexPath(row: 1, section: 2)
                    tableView.reloadRows(at: [indexPath as IndexPath], with: UITableView.RowAnimation.none)
                })
                self.present(alert, animated: true, completion: nil)
//                DispatchQueue.main.async { self.tableView.reloadData() }
                //view.setNeedsDisplay()
                //dself.currentDataLabel.text = UserDefaults.standard.string(forKey: "dataLabel")
            }
            
            //MARK:- Data Export
            if indexPath.row == 2 {
                let nowString = exportFileNameDateFormatter.string(from: Date())
                exportCSV(fileName: nowString, data: dailyRecordStore.allDailyRecords, viewController: self)
            }
        }
        // remove the higlighting right after the cell is selected
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let header = view as! UITableViewHeaderFooterView
        //header.backgroundColor = Theme.current.tableHeaderColor
        header.contentView.backgroundColor = Theme.current.tableHeaderColor
        header.textLabel?.textColor = Theme.current.textColor
    }
    
    //MARK:- Force Portrait
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated) 
        
        ApplyTheme()
        
        AppUtility.lockOrientation(.portrait)
   
        // set label
        let goalText = UserDefaults.standard.string(forKey: "dataLabel")
        userDataLabelField?.text = goalText
        currentDataLabel.text = goalText
        
       // infoCell.selectionStyle = UITableViewCell.SelectionStyle.none
        
        let monthly = IAPManager.sharedInstance.products[1]
        MonthlyLabel.text = monthly.localizedTitle
        
        let yearly = IAPManager.sharedInstance.products[0]
        YearlyLabel.text = yearly.localizedTitle
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Don't forget to reset when view is being removed
        AppUtility.lockOrientation(.all)
    }

}
