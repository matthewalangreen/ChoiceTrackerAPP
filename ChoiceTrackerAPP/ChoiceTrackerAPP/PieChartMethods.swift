//
//  PieChartMethods.swift
//  ChoiceTrackerAPP
//
//  Created by Matt Green on 8/18/18.
//  Copyright © 2018 Matt Green. All rights reserved.
//

import UIKit
import Charts

// Data needed:
// @IBOutlet pieChartView: PieChartView!

func createPieChart(record: DailyRecord) -> PieChartView {
    let currentChartView = PieChartView()
    // Setup
    var badChoices = PieChartDataEntry(value: 0)
    var goodChoices = PieChartDataEntry(value: 0)
    var numberOfDataEntries = [PieChartDataEntry]()
    let chartDataSet = PieChartDataSet(values: numberOfDataEntries, label: nil)
    let chartData = PieChartData(dataSet: chartDataSet)
    
    // Config
    goodChoices.value = Double(record.numGoodChoices)
    goodChoices.label = "Good"
    badChoices.value = Double(record.numBadChoices)
    badChoices.label = "Bad"
    numberOfDataEntries = [goodChoices, badChoices]
    
    
    // color and config
    let otherBadColor = UIColor.init(red: 247/255, green: 113/255, blue: 93/255, alpha: 1)
    let otherGoodColor = UIColor.init(red: 1/255, green: 165/255, blue: 141/255, alpha: 1)
    let colors = [otherGoodColor, otherBadColor]
    chartDataSet.colors = colors
    currentChartView.data = chartData
    chartDataSet.drawValuesEnabled = true
    
    // more formatting
    currentChartView.chartDescription?.text = ""
    currentChartView.drawEntryLabelsEnabled = false
    currentChartView.entryLabelColor = NSUIColor.black
    currentChartView.holeColor = UIColor.init(red: 243/255, green: 242/255, blue: 240/255, alpha: 1)
    currentChartView.legend.enabled = false
    
    //Data formatting ... hide the decimal values
    let format = NumberFormatter()
    format.numberStyle = .none
    let formatter = DefaultValueFormatter(formatter: format)
    chartData.setValueFormatter(formatter)
    
    return currentChartView
}

