//
//  ViewController.swift
//  ChoiceTrackerAPP
//
//  Created by Matt Green on 8/16/18.
//  Copyright © 2018 Matt Green. All rights reserved.
//

import UIKit
import Charts

class MainViewController: UIViewController {
    
    //MARK:- Model
    var dailyRecordStore: DailyRecordStore!
    var currentDailyRecord: DailyRecord!
    
    //MARK:- Outlets
    @IBOutlet var pieChartView: PieChartView!
    
    //MARK:- Override built-in functions
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //MARK:- Fake Data
        for _ in 0..<20 {
            dailyRecordStore.createRandomDailyRecord()
        }
        
        // show chart on load
        currentDailyRecord = getCurrentDailyRecord()
        
        styleChart(chart: pieChartView, goodChoices: currentDailyRecord.numGoodChoices, badChoices: currentDailyRecord.numBadChoices)
        updateUI()
    }

    //MARK:- Actions
    @IBAction func addBadChoice(_ sender: Any) {
        pieChartView.highlightValue(x: 1, dataSetIndex: 0)
        incrementChoice(choice: "Bad")
        styleChart(chart: pieChartView, goodChoices: currentDailyRecord.numGoodChoices, badChoices: currentDailyRecord.numBadChoices)
        updateUI()
    }
    
    @IBAction func addGoodChoice(_ sender: Any) {
        pieChartView.highlightValue(x: 0, dataSetIndex: 0)
        incrementChoice(choice: "Good")
        styleChart(chart: pieChartView, goodChoices: currentDailyRecord.numGoodChoices, badChoices: currentDailyRecord.numBadChoices)
        updateUI()
    }

    //MARK:- Segue
    
    // send over the [DailyRecord] array of all the records that we've got here
    // this will be used to populated the table
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "showHistory"?:
            let navVC = segue.destination as! UINavigationController
            let destinationVC = navVC.viewControllers.first as! HistoryTableViewController
            destinationVC.allRecords = [DailyRecord](dailyRecordStore.allDailyRecords.values)
            destinationVC.recordDictionary = dailyRecordStore.allDailyRecords
            
        case "showSettings"?:
            let navVC = segue.destination as! SettingsNavigationController
            let destinationVC = navVC.viewControllers.first as! SettingsTableViewController
            destinationVC.successString = "showSettings"
            destinationVC.settingsDailyRecordStore = dailyRecordStore
        default:
            preconditionFailure("Unexpected segue identifier")
        }
    }
    
    //MARK:- UI Logic
    func updateUI() {
        self.view.setNeedsDisplay()
    }
    
    //MARK:- Choice Logic
    public func incrementChoice(choice: String) {
        print(" \(choice) choice")
        
        switch choice {
        case "Good":
            currentDailyRecord.goodChoice()
           // gaugeValue += 5
        case "Bad":
            currentDailyRecord.badChoice()
           // gaugeValue -= 5
        default:
            print("not a valid choice")
        }
    }
    
    func doesRecordExist(_ day: String) -> Bool {
        return dailyRecordStore.allDailyRecords.keys.contains(day)
    }
    
    func getCurrentDailyRecord() -> DailyRecord {
        let todayString = sortableShortDate.string(from: Date.init())
        // check allDailyRecords for today, if today exists return
        if (doesRecordExist(todayString)) {
            return dailyRecordStore.allDailyRecords[todayString]! // eew
        } else {
            // if today doesn't exist, make it and return it.
            return dailyRecordStore.createDailyRecord()
        }
    }
}

