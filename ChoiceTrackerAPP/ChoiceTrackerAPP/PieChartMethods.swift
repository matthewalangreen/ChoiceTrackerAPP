//
//  PieChartMethods.swift
//  ChoiceTrackerAPP
//
//  Created by Matt Green on 8/18/18.
//  Copyright © 2018 Matt Green. All rights reserved.
//

import UIKit
import Charts

func styleChart(chart: PieChartView, goodChoices: Int, badChoices: Int) {
    var numberOfDataEntries = [PieChartDataEntry]()
    
    let badChoices = PieChartDataEntry.init(value: Double(badChoices))
    let goodChoices = PieChartDataEntry.init(value: Double(goodChoices))
    
    numberOfDataEntries = [goodChoices, badChoices]
    updateChartData(chart: chart, numberOfDataEntries: numberOfDataEntries)
}


func updateChartData(chart: PieChartView, numberOfDataEntries: [PieChartDataEntry]) {
    let chartDataSet = PieChartDataSet(values: numberOfDataEntries, label: nil)
    let chartData = PieChartData(dataSet: chartDataSet)
    
    let format = NumberFormatter()
    format.numberStyle = .none
    let formatter = DefaultValueFormatter(formatter: format)
    chartData.setValueFormatter(formatter)
    
    let otherBadColor = UIColor.init(red: 247/255, green: 113/255, blue: 93/255, alpha: 1)
    let otherGoodColor = UIColor.init(red: 1/255, green: 165/255, blue: 141/255, alpha: 1)
    let colors = [otherGoodColor, otherBadColor]
    chartDataSet.colors = colors
    
    chart.data = chartData
    formatChart(chart: chart)
    chartDataSet.drawValuesEnabled = true
}

func formatChart(chart: PieChartView) {
    chart.chartDescription?.text = ""
    chart.drawEntryLabelsEnabled = false
    chart.entryLabelColor = NSUIColor.black
    chart.holeColor = UIColor.init(red: 243/255, green: 242/255, blue: 240/255, alpha: 1)
    chart.legend.enabled = false
    chart.noDataText = "Make a great choice!"
    chart.noDataTextColor = UIColor.init(red: 1/255, green: 165/255, blue: 141/255, alpha: 1)
}
