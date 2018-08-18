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
    
    
    //MARK:- Override built-in functions
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // make some fake data
        for _ in 0..<20 {
            dailyRecordStore.createRandomDailyRecord()
        }
        
        currentDailyRecord = getCurrentDailyRecord()
        updateUI()
        
        goodChoices.value = Double(currentDailyRecord.numGoodChoices)
        goodChoices.label = "Good"
        
        badChoices.value = Double(currentDailyRecord.numBadChoices)
        badChoices.label = "Bad"
        
        numberOfDataEntries = [goodChoices, badChoices]
        
        
        updateChartData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK:- Outlets
    @IBOutlet var pieChartView: PieChartView!
    
    //MARK:- Actions
    @IBAction func addBadChoice(_ sender: Any) {
        pieChartView.highlightValue(x: 1, dataSetIndex: 0)
        incrementChoice(choice: "Bad")
        badChoices.value = Double(currentDailyRecord.numBadChoices)
        updateChartData()
        updateUI()
        //print("# Bad Choices: \(currentDailyRecord.numBadChoices)")
        
        print("total records: \(dailyRecordStore.allDailyRecords.count)")
    }
    
    @IBAction func addGoodChoice(_ sender: Any) {
        pieChartView.highlightValue(x: 0, dataSetIndex: 0)
        incrementChoice(choice: "Good")
        goodChoices.value = Double(currentDailyRecord.numGoodChoices)
        updateChartData()
        updateUI()
        print("# Good Choices: \(currentDailyRecord.numGoodChoices)")
        //        let r = [DailyRecord](dailyRecordStore.allDailyRecords.values)
        //        for v in r {
        //            print("date: \(v.dateString)")
        //        }
    }

    //MARK:- Segue
    
    // send over the [DailyRecord] array of all the records that we've got here
    // this will be used to populated the table
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! HistoryTableViewController
        destinationVC.allRecords = [DailyRecord](dailyRecordStore.allDailyRecords.values)
    }


    //MARK:- PieChart stuff
    var badChoices = PieChartDataEntry(value: 0)
    var goodChoices = PieChartDataEntry(value: 0)
    
    var numberOfDataEntries = [PieChartDataEntry]()
    
    func updateChartData() {
        // hide a chart if there is no data
        //chartOne.isHidden = true
        let chartDataSet = PieChartDataSet(values: numberOfDataEntries, label: nil)
        
        let chartData = PieChartData(dataSet: chartDataSet)
        
        let format = NumberFormatter()
        format.numberStyle = .none
        let formatter = DefaultValueFormatter(formatter: format)
        chartData.setValueFormatter(formatter)

        
        let otherBadColor = UIColor.init(red: 247/255, green: 113/255, blue: 93/255, alpha: 1)
        let otherGoodColor = UIColor.init(red: 1/255, green: 165/255, blue: 141/255, alpha: 1)
        //let backgroundColor = UIColor.init(red: 243/255, green: 242/255, blue: 240/255, alpha: 1)
        
        let colors = [otherGoodColor, otherBadColor]
        
        chartDataSet.colors = colors
        
        pieChartView.data = chartData
      
        formatChart(chartName: pieChartView)
        
        chartDataSet.drawValuesEnabled = true
   
    }
    
    func formatChart(chartName: PieChartView) {
        // format the pieChart
        chartName.chartDescription?.text = ""
        //chartName.centerText = "ChoiceTracker"
        chartName.drawEntryLabelsEnabled = false
        //pieChartView.drawSlicesUnderHoleEnabled = false
        //pieChartView.transparentCircleRadiusPercent = 0
        //pieChartView.drawHoleEnabled = false
        chartName.entryLabelColor = NSUIColor.black
        chartName.holeColor = UIColor.init(red: 243/255, green: 242/255, blue: 240/255, alpha: 1)
        chartName.legend.enabled = false
        chartName.noDataText = "Make a great choice!"
        chartName.noDataTextColor = UIColor.init(red: 1/255, green: 165/255, blue: 141/255, alpha: 1)
    }
    
    
    
    // dateFormatter
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        formatter.locale = Locale(identifier: "en_US")
        return formatter
    }()
    
    
    //MARK:- UI Logic
    func updateUI() {
//        currentScoreUITextField.text = String(currentDailyRecord.sum)
//        numChoicesUITextField.text = String(currentDailyRecord.numAllChoices)
//        numGoodChoicesUITextField.text = String(currentDailyRecord.numGoodChoices)
//        numBadChoicesUITextField.text = String(currentDailyRecord.numBadChoices)
       // updateGauge()
//        currentDailyRecord = getCurrentDailyRecord()
        
        self.view.setNeedsDisplay()
    }
    
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

