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
    @IBAction func dismissPopup(_ sender: Any) {
        presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    
    var allRecords: [DailyRecord]!
    
    
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
        let record = allRecords[indexPath.row]
        
        //let val: String = "Date: \(record.dateString) Good# \(record.numGoodChoices) Bad# \(record.numBadChoices)"
        //cell.textLabel?.text = val
        
        cell.dateLabel?.text = record.dateString
        
        styleChart(chart: cell.pieChart, goodChoices: record.numGoodChoices, badChoices: record.numBadChoices)
      
        return cell
    }
 
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 120

        // show the data
//        for v in allRecords {
//            print("date: \(v.dateString)")
//        }
    }

}
