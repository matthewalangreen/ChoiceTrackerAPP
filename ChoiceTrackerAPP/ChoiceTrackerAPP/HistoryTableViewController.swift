//
//  HistoryTableViewController.swift
//  ChoiceTrackerAPP
//
//  Created by Matt Green on 8/17/18.
//  Copyright © 2018 Matt Green. All rights reserved.
//

import UIKit

class HistoryTableViewController: UITableViewController {
    
    var allRecords: [DailyRecord]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        for v in allRecords {
            print("date: \(v.dateString)")
        }
    }
    
}
