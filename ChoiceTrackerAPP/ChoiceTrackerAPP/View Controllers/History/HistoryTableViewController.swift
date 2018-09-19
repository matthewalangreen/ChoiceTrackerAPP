//
//  HistoryTableViewController.swift
//  ChoiceTrackerAPP
//
//  Created by Matt Green on 8/17/18.
//  Copyright © 2018 Matt Green. All rights reserved.
//

import UIKit
import Charts


class HistoryTableViewController: UITableViewController {
    
    
    //MARK:- Actions
    @IBAction func dismissPopup(_ sender: Any) {
        presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    //MARK:- Parameters
    var allRecords: [DailyRecord]!
    var recordDictionary: [String:DailyRecord]!
    var sortedRecords: [(key: String, value: DailyRecord)]!
    
    
    //MARK:- TableView methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allRecords.count
    }
    
    override func tableView(_ tableView: UITableView,
                            cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Create an instance of UITableViewCell, with default appearance
        let cell = tableView.dequeueReusableCell(withIdentifier: "HistoryCell", for: indexPath) as! HistoryCell
        
        // Set the text on the cell with the description of the item
        // that is at the nth index of items, where n = row this cell
        // will appear in on the tableview
       // let record = allRecords[indexPath.row]
        let dateStringOldFormat = sortedRecords[indexPath.row].key
        let currentDailyRecord = sortedRecords[indexPath.row].value
       
        let dateObject = sortableShortDate.date(from: dateStringOldFormat)
        let newDateString = prettyDateFormatter.string(from: dateObject!)  //eew
        cell.dateLabel?.text = newDateString
        cell.backgroundColor = Theme.current.backgroundColor
        cell.dateLabel?.textColor = Theme.current.historyCellTextColor
        cell.goalLabel?.text = UserDefaults.standard.string(forKey: "dataLabel")
       
        styleChart(chart: cell.pieChart, goodChoices: currentDailyRecord.numGoodChoices, badChoices: currentDailyRecord.numBadChoices)
        return cell
    }
 
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // set background view to match theme
        self.view.backgroundColor = Theme.current.backgroundColor
        
        // apply bar color theme
        let navBar = self.navigationController?.navigationBar
        // change the bar tint color to change what the color of the bar itself looks like
        navBar?.barTintColor = Theme.current.headerColor
        // back button
        navBar?.tintColor = Theme.current.textColor
        navBar?.isTranslucent = false
        //  title color
        navBar?.titleTextAttributes = [NSAttributedStringKey.foregroundColor: Theme.current.textColor]
        
        
        tableView.allowsSelection = false
        tableView.rowHeight = 150
        
        // remove bottom of table view
        tableView.tableFooterView = UIView()
        
        // remove today from the dictionary... hope this works!
        //MARK:- **BUG -- FIXED?** This solution created an index out of range error on the last cell
        // of the table view... not sure why... nor how to fix it at this time
        //recordDictionary[sortableShortDate.string(from: Date.init())] = nil
        sortedRecords = recordDictionary.sorted(by: { $0.0 < $1.0 } )
    }
    
    //MARK:- Force Portrait
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // set background view to match theme
        self.view.backgroundColor = Theme.current.backgroundColor
        
        // apply bar color theme
        let navBar = self.navigationController?.navigationBar
        // change the bar tint color to change what the color of the bar itself looks like
        navBar?.barTintColor = Theme.current.headerColor
        // back button
        navBar?.tintColor = Theme.current.textColor
        navBar?.isTranslucent = false
        //  title color
        navBar?.titleTextAttributes = [NSAttributedStringKey.foregroundColor: Theme.current.textColor]
        
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

