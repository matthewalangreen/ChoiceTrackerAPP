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
    
    // deprecated
//    let sortedTuple: [(key: String, value: DailyRecordV2)] = data.sorted(by: { $0.0 < $1.0 })
//
//    var sortedObjectArray = [DailyRecordV2]()
//
//    for r in sortedTuple {
//        sortedObjectArray.append(r.value)
//    }
//
//    for r in sortedObjectArray {
//        let newLine = "\(r.dateString),\(r.numGoodChoices),\(r.numBadChoices),\(r.numAllChoices),\(r.goalString)\n"
//        csvText.append(contentsOf: newLine)
//    }
    
    // This is the new header for a differently-styled sheet to include the notes with each choice
    //
    /*
     
     Date    |   Choice_Type     |   Goal        |   Note                                          |
     ----------------------------------------------------------------------------------------------
     July 1  |   Good            |   "Be rad"    |   "Complemented a stranger"                     |
     July 1  |   Bad             |   "Be rad"    |   "Flipped off the driver next to me"           |
     July 2  |   Good            |   "Be rad"    |   "Made dinner for my bride"                    |
     
     
     */
    var newCSVText = "Date,Choice_Type,Goal,Note\n"
    
        let sortedTuple: [(key: String, value: DailyRecordV2)] = data.sorted(by: { $0.0 < $1.0 })
    
        var sortedObjectArray = [DailyRecordV2]()
    
        for r in sortedTuple {
            sortedObjectArray.append(r.value)
        }
    
        for r in sortedObjectArray {
            let choices = r.choices
            for c in choices {
                let newLine = "\(r.dateString),\(c.type),\(r.goalString),\(c.note)\n"
                newCSVText.append(contentsOf: newLine)
            }
        }

    
    do {
        try newCSVText.write(to: path!, atomically: true, encoding: String.Encoding.utf8)
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
