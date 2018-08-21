//
//  CSV-Export.swift
//  ChoiceTrackerAPP
//
//  Created by Matt Green on 8/20/18.
//  Copyright © 2018 Matt Green. All rights reserved.
//

import UIKit
import Foundation
import CSVExporter

func exportToCSV(fileNameDotCSV: String, dataToExport: [DailyRecord]) {
    let documents = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)
    guard let path = documents.first else { return }
    let filePath = String(NSString(string:path).appendingPathComponent(fileNameDotCSV))
    
    guard let url = NSURL(string: filePath) else { return }
    
    let operation = CSVOperation(filePath: url as URL, source: dataToExport)
    
    operation.completionBlock = {
        
//        if operation.finishedState == .Success {
//
//            //File has been saved to disk ...
//            print("file saved")
//        }
    }
    OperationQueue().addOperation(operation)
}
