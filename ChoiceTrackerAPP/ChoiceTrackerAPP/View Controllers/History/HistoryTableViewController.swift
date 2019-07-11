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
    //MARK:- Status bar style
    override var preferredStatusBarStyle: UIStatusBarStyle {
//        return UserDefaults.standard.bool(forKey: "LightTheme") ? .default : .lightContent
        return .lightContent
    }
    
    
    //MARK:- Parameters
    var allRecords: [DailyRecord]!
    var recordDictionary: [String:DailyRecord]!
    var sortedRecords: [(key: String, value: DailyRecord)]!
    var reverseSortedRecords: [(key: String, value: DailyRecord)]!
    var selectedRow: Int = 0
    
    
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
       // let dateStringOldFormat = sortedRecords[indexPath.row].key
       // let currentDailyRecord = sortedRecords[indexPath.row].value
        
        let dateStringOldFormat = reverseSortedRecords[indexPath.row].key
        let currentDailyRecord = reverseSortedRecords[indexPath.row].value
       
        let dateObject = sortableShortDate.date(from: dateStringOldFormat)
        let newDateString = prettyDateFormatter.string(from: dateObject!)  //eew
        cell.dateLabel?.text = newDateString
        cell.backgroundColor = Theme.current.backgroundColor
        cell.dateLabel?.textColor = Theme.current.historyCellTextColor
        cell.goalLabel?.text = currentDailyRecord.goalString
        cell.goalLabel?.textColor = UIColor.init(named: "light-good")
        cell.goalLabel.sizeToFit()
       
        if currentDailyRecord.numAllChoices == 0 {
            setupChart(chart: cell.pieChart)
            // remove all highlights
            cell.pieChart.highlightValue(x: 1, dataSetIndex: -1)
        } else {
             styleChart(chart: cell.pieChart, goodChoices: currentDailyRecord.numGoodChoices, badChoices: currentDailyRecord.numBadChoices)
        }
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
        navBar?.titleTextAttributes = [NSAttributedString.Key.foregroundColor: Theme.current.textColor]
        
        
        tableView.allowsSelection = false
        tableView.rowHeight = 150
        
        // remove bottom of table view
        tableView.tableFooterView = UIView()
    
        sortedRecords = recordDictionary.sorted(by: { $0.0 < $1.0 } )
        reverseSortedRecords = recordDictionary.sorted(by: { $0.0 > $1.0 } )
        
        self.tableView.allowsSelection = true
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
        navBar?.titleTextAttributes = [NSAttributedString.Key.foregroundColor: Theme.current.textColor]
        
        AppUtility.lockOrientation(.portrait)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Don't forget to reset when view is being removed
        AppUtility.lockOrientation(.all)
    }

}

extension HistoryTableViewController {
        //MARK:- Segue
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            switch segue.identifier {
            case "HistoryNotesVC"?:
                let destinationVC = segue.destination as! HistoryNotesVC
                destinationVC.selectedRowIndex = self.selectedRow
                destinationVC.currentRecord = reverseSortedRecords[self.selectedRow].value
                print("you switched to HistoryNotesVC")
                
            default:
                preconditionFailure("Unexpected segue identifier")
            }
        }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedRow = indexPath.row
    }
    }


