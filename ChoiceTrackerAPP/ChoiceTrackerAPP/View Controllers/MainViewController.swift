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
    //MARK:- Status bar style
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return UserDefaults.standard.bool(forKey: "LightTheme") ? .default : .lightContent
    }
    
    //MARK:- IBOutlets
    @IBOutlet var userButton: UIButton!
    @IBOutlet var logoImage: UIImageView!
   // @IBOutlet var setGoalButton: UIButton!
    
    //MARK:- Model
    var dailyRecordStore: DailyRecordStore!
    var currentDailyRecord: DailyRecord!
    
    //MARK:- Outlets
    @IBOutlet var pieChartView: PieChartView!
    
    @IBOutlet var BGView: UIView!
    @IBOutlet var TopBar: UIView!
    
    
    //MARK:- Override built-in functions
    
    
    fileprivate func renderChart() {
        // show chart that's not totally empty
        if currentDailyRecord.numAllChoices == 0 {
            setupChart(chart: pieChartView)
            // remove all highlights
            pieChartView.highlightValue(x: 1, dataSetIndex: -1)
        } else {
            styleChart(chart: pieChartView, goodChoices: currentDailyRecord.numGoodChoices, badChoices: currentDailyRecord.numBadChoices)
        }
        updateUI()
    }
    
    fileprivate func fillFakeData() {
        //Fake Data
        for _ in 0..<20 {
            dailyRecordStore.createRandomDailyRecord()
        }
    }
    
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        currentDailyRecord = getCurrentDailyRecord()
    
        applyTheme()
        
       // fillFakeData()
        
        renderChart()
    }
    
    // this happens when we dismiss either modal popup
    // if the popup was the settings view and you deleted all records then
    // it makes sure the UI is updated with the new empty record.
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        currentDailyRecord = getCurrentDailyRecord()
        
        // show choices
        //print("numGoodChoices: \(currentDailyRecord.numGoodChoices)")
        //print("numBadChoices: \(currentDailyRecord.numBadChoices)")
        

        applyTheme()
        
        // Force Portrait
        AppUtility.lockOrientation(.portrait)
        
        // show chart on load
        renderChart()
        
        //print("numAllChoices: \(currentDailyRecord.numAllChoices)")
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Don't forget to reset when view is being removed
        
        //Force Portrait
        AppUtility.lockOrientation(.all)
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
//        case "showHistory"?:
//            let navVC = segue.destination as! UINavigationController
//            let destinationVC = navVC.viewControllers.first as! HistoryTableViewController
//            destinationVC.allRecords = [DailyRecord](dailyRecordStore.allDailyRecords.values)
//            destinationVC.recordDictionary = dailyRecordStore.allDailyRecords
            
        case "showSettings"?:
            let navVC = segue.destination as! SettingsNavigationController
            let destinationVC = navVC.viewControllers.first as! SettingsTableViewController
            destinationVC.successString = "showSettings"
            destinationVC.settingsDailyRecordStore = dailyRecordStore
            destinationVC.settingsCurrentDailyRecord = currentDailyRecord
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
        //print(" \(choice) choice")
        
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
       // print("running doesRecordExist")
       // print("keys: \(dailyRecordStore)")
            return dailyRecordStore.allDailyRecords.keys.contains(day)
    }
    
    //MARK:-**START HERE**
    // do I need to effect the return type of this method to also return a flag
    // indicating that this is a new record?
    // I can't call an alert from this scope, so I'll have to do it outside here....
    func getCurrentDailyRecord() -> DailyRecord {
        let todayString = sortableShortDate.string(from: Date.init())
        // check allDailyRecords for today, if today exists return it
        if (doesRecordExist(todayString)) {
            return dailyRecordStore.allDailyRecords[todayString]! // eew
        } else {
            // if today doesn't exist, make it and return it.
            // this is the edit point to ask for a new goal
            let newRecord: DailyRecord = dailyRecordStore.createDailyRecord()
            // write the code to ask for the goal
        
            
            // set that goal to the new record, then return it
            return newRecord
        }
    }
    
    fileprivate func applyTheme() {
        // set colors by theme
        BGView.backgroundColor = Theme.current.backgroundColor
        view.backgroundColor = Theme.current.backgroundColor
        
        // change button tint color
        userButton.tintColor = Theme.current.buttonTintColor
       // historyButton.tintColor = Theme.current.buttonTintColor
       // setGoalButton.tintColor = Theme.current.buttonTintColor
        
        // set logo image
        logoImage.image = UIImage.init(named: Theme.current.logoImage)
    }
    
   
    
}

