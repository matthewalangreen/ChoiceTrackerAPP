//
//  SettingsTableTableViewController.swift
//  ChoiceTrackerAPP
//
//  Created by Matt Green on 8/17/18.
//  Copyright © 2018 Matt Green. All rights reserved.
//

import UIKit

class SettingsTableViewController: UITableViewController {
    // for alert controller
    var userDataLabelField: UITextField?
    
   //MARK:- Status bar style
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return UserDefaults.standard.bool(forKey: "LightTheme") ? .lightContent : .default
    }
    
    //MARK:- Properties
    var settingsDailyRecordStore: DailyRecordStore!  // set by "prepareForSegue" from Main View Controller
    var settingsCurrentDailyRecord: DailyRecord! // set by "prepareForSegue" from Main View Controller
    
    //MARK:- Outlets to cells
    @IBOutlet var ChoiceTrackerPro_Cell: UITableViewCell!
    @IBOutlet var ResetAllData_Cell: UITableViewCell!
    @IBOutlet var ViewChoiceHistory_Cell: UITableViewCell!
    @IBOutlet var AboutCell: UITableViewCell!
    @IBOutlet var GoalChangeCell: UITableViewCell!
    @IBOutlet var ExportDataCell: UITableViewCell!
    
    //MARK:- Outlets to labels in cells
    @IBOutlet var ChoiceTrackerProLabel: UILabel!
    @IBOutlet var ResetLabel: UILabel!
    @IBOutlet var ChoiceHistoryLabel: UILabel!
    @IBOutlet var AboutTextLabel: UILabel!
    @IBOutlet var GoalChangeLabel: UILabel!
    @IBOutlet var CurrentDataLabel: UILabel!
    @IBOutlet var ExportDataLabel: UILabel!
    
    //MARK:- ApplyTheme
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
        
        view.backgroundColor = Theme.current.backgroundColor
        ChoiceTrackerPro_Cell.backgroundColor = Theme.current.backgroundColor
        ResetAllData_Cell.backgroundColor = Theme.current.backgroundColor
        ViewChoiceHistory_Cell.backgroundColor = Theme.current.backgroundColor
        
        ChoiceTrackerProLabel.textColor = Theme.current.textColor
        ResetLabel.textColor = UIColor.init(named: "light-bad")
        ChoiceHistoryLabel.textColor = Theme.current.textColor
        
        AboutCell.backgroundColor = Theme.current.backgroundColor
        AboutTextLabel.backgroundColor = Theme.current.backgroundColor
        AboutTextLabel.textColor = Theme.current.textColor
        
        GoalChangeCell.backgroundColor = Theme.current.backgroundColor
        GoalChangeLabel.backgroundColor = Theme.current.backgroundColor
        GoalChangeLabel.textColor = Theme.current.textColor
        
        ExportDataCell.backgroundColor = Theme.current.backgroundColor
        ExportDataLabel.backgroundColor = Theme.current.backgroundColor
        ExportDataLabel.textColor = Theme.current.textColor
       
    }
    
    //MARK:- IBActions
    @IBAction func dismissPopup(_ sender: Any) {
        if let presenter = presentingViewController as? MainViewController {
           presenter.dailyRecordStore = settingsDailyRecordStore
        }
        presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
  
    //MARK:- OVERRIDE
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // set label
        let goalText = UserDefaults.standard.string(forKey: "dataLabel")
        userDataLabelField?.text = goalText
        CurrentDataLabel.text = goalText
        
        ApplyTheme()
        
        // add the little arrow to the right side of the cells
        ChoiceTrackerPro_Cell.accessoryType = .disclosureIndicator
        ViewChoiceHistory_Cell.accessoryType = .disclosureIndicator
       
        tableView.tableFooterView = UIView()
        setNeedsStatusBarAppearanceUpdate()
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Change goal tapped
        if indexPath.section == 1 {
            if indexPath.row == 1 {
                let alert: UIAlertController = changeGoalAlertWithHandler(currentDailyRecord: settingsCurrentDailyRecord, handler: {
                    self.CurrentDataLabel.text = UserDefaults.standard.string(forKey: "dataLabel")
                    let indexPath = NSIndexPath(row: 1, section: 1)  // reload this row
                    tableView.reloadRows(at: [indexPath as IndexPath], with: UITableView.RowAnimation.none)
                })
                self.present(alert, animated: true, completion: nil)
            }
            
        }
        
        if indexPath.section  == 3 {
            // "Export Data" row option
            if indexPath.row == 0 {
                let nowString = exportFileNameDateFormatter.string(from: Date())
                exportCSV(fileName: nowString, data: settingsDailyRecordStore.allDailyRecords, viewController: self)
            }
             // "Reset All Data" row action
            if indexPath.row == 1 {
                
                //Reset All data -- add action
                
                let alert = UIAlertController(title: "Reset All Data", message: "Are you sure? You cannot undo this action", preferredStyle: .alert)
                
                let yesAction = UIAlertAction(title: "Reset", style: .destructive, handler: { action in
                    self.settingsDailyRecordStore.deleteAllRecords()
                    print("All records deleted")
                })
                let noAction = UIAlertAction(title: "Cancel", style: .default, handler: nil)
                
                alert.addAction(noAction)
                alert.addAction(yesAction)
                
                
                self.present(alert, animated: true, completion: nil)
            }
        }
        
       
        
        
        // remove the higlighting right after the cell is selected
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    //MARK:- Segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "showHistory"?:
            let destinationVC = segue.destination as! HistoryTableViewController
            destinationVC.allRecords = [DailyRecord](settingsDailyRecordStore.allDailyRecords.values)
            destinationVC.recordDictionary = settingsDailyRecordStore.allDailyRecords
        case "showChoiceTrackerPro"?:
            let destinationVC = segue.destination as! ChoiceTrackerProSettingsTableView
                destinationVC.dailyRecordStore = settingsDailyRecordStore
                destinationVC.currentDailyRecord = settingsCurrentDailyRecord
        default:
            preconditionFailure("Unexpected segue identifier")
        }
    }
    
    //MARK:- Force Portrait
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let goalText = UserDefaults.standard.string(forKey: "dataLabel")
        userDataLabelField?.text = goalText
        CurrentDataLabel.text = goalText
        
        ApplyTheme()
        
        AppUtility.lockOrientation(.portrait)
    }
   
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Don't forget to reset when view is being removed
        AppUtility.lockOrientation(.all)
    }
}
