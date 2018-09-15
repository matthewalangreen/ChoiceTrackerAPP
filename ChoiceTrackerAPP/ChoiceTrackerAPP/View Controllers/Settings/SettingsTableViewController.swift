//
//  SettingsTableTableViewController.swift
//  ChoiceTrackerAPP
//
//  Created by Matt Green on 8/17/18.
//  Copyright © 2018 Matt Green. All rights reserved.
//

import UIKit

class SettingsTableViewController: UITableViewController {
    
    
    //MARK:- Properties
    
    // this will be set by "prepareForSegue"
    var settingsDailyRecordStore: DailyRecordStore!
    
    //MARK:- Outlets to cells
    
    @IBOutlet var ChoiceTrackerPro_Cell: UITableViewCell!
    @IBOutlet var About_Cell: UITableViewCell!
    
    var successString: String!
    
    @IBAction func dismissPopup(_ sender: Any) {
        if let presenter = presentingViewController as? MainViewController {
           presenter.dailyRecordStore = settingsDailyRecordStore
        }
        presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
   
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // add the little arrow to the right side of the cells
        ChoiceTrackerPro_Cell.accessoryType = .disclosureIndicator
        About_Cell.accessoryType = .disclosureIndicator
        
        // hides extra rows at end of tableview
//        let bottomView = UIView()
//        bottomView.backgroundColor = UIColor(red: 239/255, green: 0, blue: 0, alpha: 1)
        
        // r: 244, g: 244, b: 239
        
        tableView.tableFooterView = UIView()

        print("Success String Value: \(successString)")
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // if we clicked on the "Reset All Data" row
        if indexPath.section  == 2 {
            if indexPath.row == 0 {
                
                //MARK:- Reset All data -- add action
                
                let alert = UIAlertController(title: "Reset All Data", message: "Are you sure? You cannot undo this action", preferredStyle: .alert)
                
                let yesAction = UIAlertAction(title: "Yes", style: .destructive, handler: { action in
                    self.settingsDailyRecordStore.deleteAllRecords()
                    print("We just deleted your records, yo")
                })
                let noAction = UIAlertAction(title: "No", style: .default, handler: nil)
                
                alert.addAction(yesAction)
                alert.addAction(noAction)
                
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    
    //MARK:- Segue
    
    // send ove/Users/mgreen/GitHub Clones/ChoiceTrackerAPP/ChoiceTrackerAPP/ChoiceTrackerAPP/View Controllers/Settings/SettingsTableViewController.swiftr the [DailyRecord] array of all the records that we've got here
    // this will be used to populated the table
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "showChoiceTrackerPro"?:
            let destinationVC = segue.destination as! ChoiceTrackerProSettingsTableView
                destinationVC.dailyRecordStore = settingsDailyRecordStore
        case "showAbout"?:
            print("you selected showAbout")
        default:
            preconditionFailure("Unexpected segue identifier")
        }
    }

}
