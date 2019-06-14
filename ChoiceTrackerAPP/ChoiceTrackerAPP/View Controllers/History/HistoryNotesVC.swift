//
//  HistoryNotesVC.swift
//  ChoiceTrackerAPP
//
//  Created by Matt Green on 6/13/19.
//  Copyright © 2019 Matt Green. All rights reserved.
//

import UIKit

class HistoryNotesVC: UITableViewController {
    
    var selectedRowIndex: Int!
   
    //MARK:-TableView Methods
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HistoryNotesVCCell", for: indexPath) as! HistoryNotesVCCell
        cell.HistoryNotesLabel?.text = String(self.selectedRowIndex)
        return cell
    }
    
}



