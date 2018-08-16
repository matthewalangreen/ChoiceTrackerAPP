//
//  ViewController.swift
//  ChoiceTrackerAPP
//
//  Created by Matt Green on 8/16/18.
//  Copyright © 2018 Matt Green. All rights reserved.
//

import UIKit


class ViewController: UIViewController {
    // dateFormatter
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        formatter.locale = Locale(identifier: "en_US")
        return formatter
    }()
    
    // model stuff
    var dailyRecordStore: DailyRecordStore!
    var currentDailyRecord: DailyRecord!
    
    //MARK:- Outlets
//    @IBOutlet var numChoicesUITextField: UITextField!
//    @IBOutlet var numGoodChoicesUITextField: UITextField!
//    @IBOutlet var numBadChoicesUITextField: UITextField!
//    @IBOutlet var currentScoreUITextField: UITextField!
//    @IBOutlet var gaugeView: ABGaugeView!
//    @IBOutlet var littleGaugeView: ABGaugeView!
    
    
    //MARK:- Actions
//    @IBAction func addGoodChoice(_ sender: Any) {
//        incrementChoice(choice: "Good")
//        updateUI()
//        print(dailyRecordStore.allDailyRecords.count)
//    }
//
//    @IBAction func addBadChoice(_ sender: Any) {
//        incrementChoice(choice: "Bad")
//        print("Today's Date: \(currentDailyRecord.date)")
//        print(dailyRecordStore.allDailyRecords.keys)
//        updateUI()
//    }
//    @IBAction func addDailyRecord(_ sender: Any) {
//        dailyRecordStore.createRandomDailyRecord()
//        print("Today's Date: \(currentDailyRecord.date)")
//    }
    
    //MARK:- Template
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        currentDailyRecord = getCurrentDailyRecord()
        //updateUI()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK:- UI Logic
//    func updateUI() {
//        currentScoreUITextField.text = String(currentDailyRecord.sum)
//        numChoicesUITextField.text = String(currentDailyRecord.numAllChoices)
//        numGoodChoicesUITextField.text = String(currentDailyRecord.numGoodChoices)
//        numBadChoicesUITextField.text = String(currentDailyRecord.numBadChoices)
//        updateGauge()
//        currentDailyRecord = getCurrentDailyRecord()
//        self.view.setNeedsDisplay()
//    }
    
//    func updateGauge() {
//        gaugeView.needleValue = CGFloat(gaugeValue)
//        gaugeView.needleValue = CGFloat(calculatedGaugeValue())
//        littleGaugeView.needleValue = CGFloat(gaugeValue)
//        littleGaugeView.needleValue = CGFloat(calculatedGaugeValue())
//    }
    
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
    
    
    //MARK:- Gauge Stuff
//    var gaugeValue: Int = 50
//
//    func calculatedGaugeValue() -> Int {
//        let amount = Int(currentDailyRecord.choicePercentage * 100)
//        return amount
//    }
    
    //MARK:- Daily Record stuff
    func doesRecordExist(day: String) -> Bool {
        return dailyRecordStore.allDailyRecords.keys.contains(day)
    }
    
    func getCurrentDailyRecord() -> DailyRecord {
        let today = dateFormatter.string(from: Date.init())
        // check allDailyRecords for today, if today exists return
        if (doesRecordExist(day: today)) {
            return dailyRecordStore.allDailyRecords[today]! // eew
        } else {
            // if today doesn't exist, make it and return it.
            return dailyRecordStore.createDailyRecord()
        }
    }
    
}

