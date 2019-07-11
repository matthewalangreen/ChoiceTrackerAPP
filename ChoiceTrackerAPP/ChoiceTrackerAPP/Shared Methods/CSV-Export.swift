//
//  CSV-Export.swift
//  ChoiceTrackerAPP
//
//  Created by Matt Green on 8/20/18.
//  Copyright © 2018 Matt Green. All rights reserved.
//

import Foundation
import UIKit

func exportCSV(fileName: String, data: [String:DailyRecordV2], viewController: UIViewController) {
    
    let fileName = "\(fileName).csv"
    let path = NSURL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent(fileName)
    
    var csvText = "Date,Good_Choices,Bad_Choices,Total_Choices,Goal\n"
    
    let sortedTuple: [(key: String, value: DailyRecordV2)] = data.sorted(by: { $0.0 < $1.0 })
    
    var sortedObjectArray = [DailyRecordV2]()
    for r in sortedTuple {
        sortedObjectArray.append(r.value)
    }
    
    for r in sortedObjectArray {
        let newLine = "\(r.dateString),\(r.numGoodChoices),\(r.numBadChoices),\(r.numAllChoices),\(r.goalString)\n"
        csvText.append(contentsOf: newLine)
    }
    
    do {
        try csvText.write(to: path!, atomically: true, encoding: String.Encoding.utf8)
    } catch {
        print("Failed to create file")
        print("\(error)")
    }
    
    let vc = UIActivityViewController(activityItems: [path!], applicationActivities: [])
    
    // iPad stuff
    if UIDevice.current.userInterfaceIdiom == .pad {
        vc.popoverPresentationController?.sourceView = viewController.view
        vc.popoverPresentationController?.sourceRect = CGRect(x: viewController.view.bounds.midX, y: viewController.view.bounds.midY, width: 0, height: 0)
        vc.popoverPresentationController?.permittedArrowDirections = UIPopoverArrowDirection.init(rawValue: 0)
    }
    viewController.present(vc, animated: true, completion: nil)
}
