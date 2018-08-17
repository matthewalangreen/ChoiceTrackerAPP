//
//  ViewController.swift
//  ChoiceTrackerAPP
//
//  Created by Matt Green on 8/16/18.
//  Copyright © 2018 Matt Green. All rights reserved.
//

import UIKit
import Charts

class ViewController: UIViewController {
    //MARK:- Outlets
    @IBOutlet var pieChartView: PieChartView!
    @IBOutlet var chartOne: PieChartView!
    @IBOutlet var chartTwo: PieChartView!
    @IBOutlet var chartThree: PieChartView!
  
    

    //MARK:- Actions
    @IBAction func addBadChoice(_ sender: Any) {
        pieChartView.highlightValue(x: 1, dataSetIndex: 0)
        incrementChoice(choice: "Bad")
        badChoices.value = Double(currentDailyRecord.numBadChoices)
        updateChartData()
        print("# Bad Choices: \(currentDailyRecord.numBadChoices)")
    }
    
    
    @IBAction func addGoodChoice(_ sender: Any) {
        pieChartView.highlightValue(x: 0, dataSetIndex: 0)
        incrementChoice(choice: "Good")
        goodChoices.value = Double(currentDailyRecord.numGoodChoices)
        updateChartData()
        print("# Good Choices: \(currentDailyRecord.numGoodChoices)")
    }
    


    //MARK:- PieChart stuff
    var badChoices = PieChartDataEntry(value: 0)
    var goodChoices = PieChartDataEntry(value: 0)
    
    var numberOfDataEntries = [PieChartDataEntry]()
    
    func updateChartData() {
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
        
        chartDataSet.drawValuesEnabled = false
        chartOne.data = chartData
        chartTwo.data = chartData
        chartThree.data = chartData

     
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
    
    // model stuff
    var dailyRecordStore: DailyRecordStore!
    var currentDailyRecord: DailyRecord!
    

    //MARK:- Template
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        currentDailyRecord = getCurrentDailyRecord()
        //updateUI()
        
       
        // format the pieChart
//        pieChartView.chartDescription?.text = ""
//        pieChartView.centerText = "ChoiceTracker"
//        pieChartView.drawEntryLabelsEnabled = false
//        //pieChartView.drawSlicesUnderHoleEnabled = false
//        //pieChartView.transparentCircleRadiusPercent = 0
//        //pieChartView.drawHoleEnabled = false
//        pieChartView.entryLabelColor = NSUIColor.black
//        pieChartView.holeColor = UIColor.init(red: 243/255, green: 242/255, blue: 240/255, alpha: 1)
//        pieChartView.legend.enabled = false
//        pieChartView.noDataText = "Make a great choice!"
//        pieChartView.noDataTextColor = UIColor.init(red: 1/255, green: 165/255, blue: 141/255, alpha: 1)
        
        formatChart(chartName: pieChartView)
        formatChart(chartName: chartOne)
        formatChart(chartName: chartTwo)
        formatChart(chartName: chartThree)
      
        
        
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
    
    //MARK:- UI Logic
//    func updateUI() {
//        currentScoreUITextField.text = String(currentDailyRecord.sum)
//        numChoicesUITextField.text = String(currentDailyRecord.numAllChoices)
//        numGoodChoicesUITextField.text = String(currentDailyRecord.numGoodChoices)
//        numBadChoicesUITextField.text = String(currentDailyRecord.numBadChoices)
//       // updateGauge()
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

