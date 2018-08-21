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
        
        //let val: String = "Date: \(record.dateString) Good# \(record.numGoodChoices) Bad# \(record.numBadChoices)"
        //cell.textLabel?.text = val
        
       
        
        //cell.dateLabel?.text = dateFormatter.string(from: record.date)
        //cell.dateLabel?.text = record.date.description
        let dateObject = sortableShortDate.date(from: dateStringOldFormat)
        let newDateString = prettyDateFormatter.string(from: dateObject!)  //eew
        cell.dateLabel?.text = newDateString
       
        
        //styleChart(chart: cell.pieChart, goodChoices: numGoodChoices, badChoices: record.numBadChoices)
        styleChart(chart: cell.pieChart, goodChoices: currentDailyRecord.numGoodChoices, badChoices: currentDailyRecord.numBadChoices)
        return cell
    }
 
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.allowsSelection = false
        tableView.rowHeight = 150
        
        // remove today from the dictionary... hope this works!
        recordDictionary[sortableShortDate.string(from: Date.init())] = nil
        sortedRecords = recordDictionary.sorted(by: { $0.0 < $1.0 } )
        

        // show the data
//        for v in allRecords {
//            print("date: \(v.dateString)")
//        }
    }

}

//let dateFormatter: DateFormatter = {
//    let formatter = DateFormatter()
//    formatter.dateStyle = .medium
//    formatter.timeStyle = .none
//    formatter.locale = Locale(identifier: "en_US")
//    return formatter
//}()
