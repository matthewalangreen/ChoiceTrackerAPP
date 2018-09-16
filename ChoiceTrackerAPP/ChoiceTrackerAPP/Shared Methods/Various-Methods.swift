//
//  Various-Methods.swift
//  ChoiceTrackerAPP
//
//  Created by Matt Green on 8/20/18.
//  Copyright © 2018 Matt Green. All rights reserved.
//

import UIKit

func generateRandomDate(daysBack: Int)-> Date?{
    let day = arc4random_uniform(UInt32(daysBack))+1
    let hour = arc4random_uniform(23)
    let minute = arc4random_uniform(59)
    
    let today = Date(timeIntervalSinceNow: 0)
    let gregorian  = NSCalendar(calendarIdentifier: NSCalendar.Identifier.gregorian)
    var offsetComponents = DateComponents()
    offsetComponents.day = Int(day - 1)
    offsetComponents.hour = Int(hour)
    offsetComponents.minute = Int(minute)
    
    let randomDate = gregorian?.date(byAdding: offsetComponents, to: today, options: .init(rawValue: 0) )
    return randomDate
}

//MARK:- Testing... Remove?
// helper function to fill up data at outset... remove after testing complete?
func genRandomData(_ arrayLength: Int) -> [Int] {
    var results = [Int]()
    for _ in 0..<arrayLength {
        if(Int(arc4random_uniform(UInt32(2)))) == 1 {
            results.append(-1)
        } else {
            results.append(1)
        }
    }
    return results
}







