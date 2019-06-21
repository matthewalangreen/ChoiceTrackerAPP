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
        return UserDefaults.standard.bool(forKey: "LightTheme") ? .lightContent : .default
    }
    
    //MARK:- IBOutlets
    @IBOutlet var userButton: UIButton!
    @IBOutlet var logoImage: UIImageView!
    
    //MARK:- Properties
    var dailyRecordStore: DailyRecordStore!
    var currentDailyRecord: DailyRecord!
    
    //MARK:- Outlets
    @IBOutlet var pieChartView: PieChartView!
    @IBOutlet var BGView: UIView!
    @IBOutlet var TopBar: UIView!
    
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
        
       
        
//        let checkRecord = getCurrentDailyRecordTuple()
//        print("checkRecord.0 \(checkRecord.0)")
//        currentDailyRecord = checkRecord.0
//        print(currentDailyRecord!)
//        if (checkRecord.1 == true) { // if its a new daily record
//            let alert: UIAlertController = changeGoalAlert(currentDailyRecord: currentDailyRecord)
//            self.present(alert, animated: true, completion: nil)
//            print("first time you've used this app today")
//        } else {
//            print("you've used this app at least once today")
//        }
        
        
//        let checkRecord = getCurrentDailyRecordTuple()
//        print("checkRecord.0 \(checkRecord.0) checkRecord.1 \(checkRecord.1)")
//        currentDailyRecord = checkRecord.0
//        if (checkRecord.1 == true) { // if its a new daily record
//            let alert: UIAlertController = changeGoalAlert(currentDailyRecord: currentDailyRecord)
//            self.present(alert, animated: true, completion: nil)
//        }
//        applyTheme()

//        renderChart()
//        setNeedsStatusBarAppearanceUpdate()
        
         // fillFakeData()
    }
    
    // this happens when we dismiss either modal popup
    // if the popup was the settings view and you deleted all records then
    // it makes sure the UI is updated with the new empty record.
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    
//        applyTheme()
//        renderChart()
//        setNeedsStatusBarAppearanceUpdate()
    
        // Force Portrait
        AppUtility.lockOrientation(.portrait)
        applyTheme()
        renderChart()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        // check record
        let recordCheck = getCurrentDailyRecordTuple()
        
        // assign record
        currentDailyRecord = recordCheck.0
        
        // show alert if this is the first time you've used the app today
        if (recordCheck.1 == true) { // if its a new daily record
            print("you haven't used the app yet today")
            let alert: UIAlertController = changeGoalAlert(currentDailyRecord: currentDailyRecord)
            self.present(alert, animated: true, completion: nil)
        } else {
         print("you've used the app at least once today")
        }
        
        applyTheme()
        renderChart()
        setNeedsStatusBarAppearanceUpdate()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
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
    
    @IBAction func handleGesture(_ sender: UILongPressGestureRecognizer) {
        if sender.state == .began
        {
            //print("long pressed good choice")
            //TODO: present popup for description
            let ac = alertWithField()
            self.present(ac, animated: true, completion: nil)
        }
    }

    @IBAction func handeBadChoiceLongPress(_ sender: UILongPressGestureRecognizer) {
        if sender.state == .began {
            //print("long pressed bad choice")
            //TODO: Present popup for description text
            let ac = alertWithField()
            self.present(ac, animated: true, completion: nil)
        }
    }
    //MARK:- Segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "showSettings"?:
            let navVC = segue.destination as! SettingsNavigationController
            let destinationVC = navVC.viewControllers.first as! SettingsTableViewController
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
        switch choice {
        case "Good":
            currentDailyRecord.goodChoice()
        case "Bad":
            currentDailyRecord.badChoice()
        default:
            print("not a valid choice")
        }
    }
    func doesRecordExist(_ day: String) -> Bool {
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
    
    func getCurrentDailyRecordTuple() -> (DailyRecord,Bool) {
        let todayString = sortableShortDate.string(from: Date.init())
        // check allDailyRecords for today, if today exists return it
        if (doesRecordExist(todayString)) {
            return (dailyRecordStore.allDailyRecords[todayString]!,false) // eew
        } else {
            // if today doesn't exist, make it and return it.
            // this is the edit point to ask for a new goal
            let newRecord: DailyRecord = dailyRecordStore.createDailyRecord()
            // write the code to ask for the goal
            
            
            // set that goal to the new record, then return it
            return (newRecord,true)
        }
    }
    
    fileprivate func applyTheme() {
        // set colors by theme
        BGView.backgroundColor = Theme.current.backgroundColor
        view.backgroundColor = Theme.current.backgroundColor
        
        // change button tint color
        userButton.tintColor = Theme.current.buttonTintColor
      
        // set logo image
        logoImage.image = UIImage.init(named: Theme.current.logoImage)
    }   
}

