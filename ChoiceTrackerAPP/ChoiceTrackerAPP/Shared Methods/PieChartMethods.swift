//
//  PieChartMethods.swift
//  ChoiceTrackerAPP
//
//  Created by Matt Green on 8/18/18.
//  Copyright © 2018 Matt Green. All rights reserved.
//

import UIKit
import Charts

// run this once to put something between 0 and 1 to show a chart that's empty but not
// totally empty
func setupChart(chart: PieChartView) {
    var numberOfDataEntries = [PieChartDataEntry]()
    
    let badChoices = PieChartDataEntry.init(value: 0.1)
    let goodChoices = PieChartDataEntry.init(value: 0.1)
    
    numberOfDataEntries = [goodChoices, badChoices]
    updateChartData(chart: chart, numberOfDataEntries: numberOfDataEntries)
}

// primary method to use once a user has pressed a button
func styleChart(chart: PieChartView, goodChoices: Int, badChoices: Int) {
    var numberOfDataEntries = [PieChartDataEntry]()
    
    let badChoices = PieChartDataEntry.init(value: Double(badChoices))
    let goodChoices = PieChartDataEntry.init(value: Double(goodChoices))
    
    numberOfDataEntries = [goodChoices, badChoices]
    updateChartData(chart: chart, numberOfDataEntries: numberOfDataEntries)
}

// helper function for styleChart()
func updateChartData(chart: PieChartView, numberOfDataEntries: [PieChartDataEntry]) {
    let chartDataSet = PieChartDataSet(values: numberOfDataEntries, label: nil)
    let chartData = PieChartData(dataSet: chartDataSet)
    
    let format = NumberFormatter()
    format.numberStyle = .none
    let formatter = DefaultValueFormatter(formatter: format)
    chartData.setValueFormatter(formatter)
    
    // not sure about this forced unwrapping...
    let goodColor = Theme.current.goodColor
    let badColor = Theme.current.badColor
    let colors = [goodColor, badColor]
    chartDataSet.colors = colors
    
    chart.data = chartData
    formatChart(chart: chart)
    chartDataSet.drawValuesEnabled = true
}

// helper function for updateChartData()
func formatChart(chart: PieChartView) {
    chart.chartDescription?.text = ""
    chart.drawEntryLabelsEnabled = false
    chart.entryLabelColor = NSUIColor.black
    chart.holeColor = Theme.current.backgroundColor
    chart.legend.enabled = false
    chart.noDataText = "Make a great choice!"
    chart.noDataTextColor = Theme.current.backgroundColor 
}
