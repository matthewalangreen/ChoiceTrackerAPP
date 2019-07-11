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
    var currentRecord: DailyRecordV2!
    
    override func viewWillAppear(_ animated: Bool) {
        super .viewWillAppear(animated)
        print("Current record: \(currentRecord)")
        
    }
   
    //MARK:-TableView Methods
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentRecord.choices.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HistoryNotesVCCell", for: indexPath) as! HistoryNotesVCCell
        cell.HistoryNotesLabel?.text = String(self.selectedRowIndex)
        
        
        
        let choices = currentRecord.choices
        let choice = choices[indexPath.row]
        //let notes = currentRecord.notes
        //let note = notes[indexPath.row]

        if choice.type == .good  { //Good choice
            cell.HistoryNotesLabel?.text = "+ choice. Note: \(choice.note)"
        }

        if choice.type == .bad { // Bad choice
            cell.HistoryNotesLabel?.text = "- choice. Note: \(choice.note)"
        }
       

       
        
        
        return cell
    }
    
}



