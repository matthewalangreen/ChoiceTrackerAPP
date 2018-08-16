//
//  DailyChoices.swift
//  ChoiceTracker
//
//  Created by Matt Green on 8/8/18.
//  Copyright © 2018 Matt Green. All rights reserved.
//

//import Foundation

public class DailyChoices {
    var choices: [Int] = [0]
    
    // computed properties
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
    
    var choicePercentage: Float {
        let ratio = Float(numGoodChoices) / Float(numAllChoices)
        return ratio
    }
    
    public init() {}
    
    // setters
    func goodChoice() {
        choices.append(1)
    }
    
    func badChoice() {
        choices.append(-1)
    }


}
