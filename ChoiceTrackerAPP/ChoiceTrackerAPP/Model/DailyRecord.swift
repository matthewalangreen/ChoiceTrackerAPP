//
//  DailyRecord.swift
//  ChoiceTrackerAPP
//
//  Created by Matt Green on 8/16/18.
//  Copyright © 2018 Matt Green. All rights reserved.
//

import UIKit

class DailyRecord: NSObject, NSCoding {
    
    //MARK:- properties
    var choices: [Int]
    var dateString: String
    
    //MARK:- init
    override init() {
        self.choices = [0]
        self.dateString = "1111"
    }
    
    init(nowDateString: String) {
        self.dateString = nowDateString
        self.choices = [0]
    }
    
    //MARK:- NSCoding required methods
    func encode(with aCoder: NSCoder) {
        aCoder.encode(choices, forKey: "choices")
        aCoder.encode(dateString, forKey: "dateString")
    }
    
    required init(coder aDecoder: NSCoder) {
        choices = aDecoder.decodeObject(forKey: "choices") as! [Int]
        dateString = aDecoder.decodeObject(forKey: "dateString") as! String
        super.init()
    }
    
    //MARK:- computed properties
    var sum: Int {
        return choices.reduce(0,+)
    }
    
    var numAllChoices: Int {
        return choices.count - 1
    }
    
    var numGoodChoices: Int {
        var count = 0
        for item in choices {
            if item == 1 {
                count += 1
            }
        }
        return count
    }
    
    var numBadChoices: Int {
        var count = 0
        for item in choices {
            if item == -1 {
                count += 1
            }
        }
        return count
    }
    
    // optional binding to catch the potential for no value for gauge when we haven't recorded data yet
    var choicePercentage: Float {
        var ratio: Float = 0
        let num = Float(numGoodChoices)
        let denom = Float(numAllChoices)
        if(denom == 0) {
            ratio = 0
        } else {
            ratio = num / denom
        }
        return ratio
    }
    
    
    //MARK:- setters
    func goodChoice() {
        choices.append(1)
    }
    
    func badChoice() {
        choices.append(-1)
    }
    
}

