//
//  ViewController.swift
//  ChartsTableView
//
//  Created by Matt Green on 8/18/18.
//  Copyright © 2018 Matt Green. All rights reserved.
//

import UIKit
import Charts

class MainViewController: UIViewController {
    @IBOutlet var pcView: PieChartView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        styleChart(chart: pcView, goodChoices: 0, badChoices: 0)
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

