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
    
    //MARK:- Segue
    
    // send ove/Users/mgreen/GitHub Clones/ChoiceTrackerAPP/ChoiceTrackerAPP/ChoiceTrackerAPP/View Controllers/Settings/SettingsTableViewController.swiftr the [DailyRecord] array of all the records that we've got here
    // this will be used to populated the table
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "showChoiceTrackerPro"?:
            let destinationVC = segue.destination as! ChoiceTrackerProSettingsTableView
                destinationVC.dailyRecordStore = settingsDailyRecordStore
        default:
            preconditionFailure("Unexpected segue identifier")
        }
    }

}
