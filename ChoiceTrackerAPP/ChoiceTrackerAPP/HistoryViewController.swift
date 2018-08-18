//
//  HistoryViewController.swift
//  ChoiceTrackerAPP
//
//  Created by Matt Green on 8/17/18.
//  Copyright © 2018 Matt Green. All rights reserved.
//

import UIKit
import Charts

class HistoryViewController: UIViewController {

    //MARK:- Outlets
    @IBOutlet var yesterdayPieChart: PieChartView!
    
    //MARK:- Actions
    @IBAction func dismissPopu(_ sender: Any) {
        dismiss(animated: true, completion: nil)
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
        
        yesterdayPieChart.data = chartData
        
        formatChart(chartName: yesterdayPieChart)
        
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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        goodChoices.value = Double(12)
        goodChoices.label = "Good"
        
        badChoices.value = Double(5)
        badChoices.label = "Bad"
        
        numberOfDataEntries = [goodChoices, badChoices]
        
        
        updateChartData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
