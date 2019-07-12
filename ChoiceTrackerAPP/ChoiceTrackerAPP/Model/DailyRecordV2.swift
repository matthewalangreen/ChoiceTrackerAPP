//
//  DailyRecordV2.swift
//  ChoiceTrackerAPP
//
//  Created by Matthew Green on 7/11/19.
//  Copyright © 2019 Matt Green. All rights reserved.
//


import UIKit

struct Choice: Codable {
    enum ChoiceType: Int, Codable {
        case good = 1
        case bad = -1
    }
    
    var type: ChoiceType
    var note: String
    
    init(choiceType: ChoiceType, note: String) {
        self.type = choiceType
        self.note = note
    }
}

class DailyRecordV2: Codable {
    
    //MARK:- properties
    var choices = [Choice]() //testing
    var dateString: String   // encode using "sortableShortDate" closure
    var goalString: String
    
    //MARK:- init
    init() {
        self.choices = [Choice]()
        self.dateString = sortableShortDate.string(from: Date.init())
        
        if let goal = UserDefaults.standard.string(forKey: "dataLabel") {
            self.goalString = goal
        } else {
            self.goalString = "No goal set"
        }
    }
    
    init(nowDateString: String) {
        self.dateString = nowDateString
        self.choices = [Choice]()

        if let goal = UserDefaults.standard.string(forKey: "dataLabel") {
            self.goalString = goal
        } else {
            self.goalString = "No goal set"
        }
    }
    
    init(nowDateString: String, firstTimeToday: Bool) {
        self.dateString = nowDateString
        
        if firstTimeToday {
            self.choices = []
        } else {
            //self.choices = genRandomData(40)
            self.choices = [Choice]()
        }
        
        if let goal = UserDefaults.standard.string(forKey: "dataLabel") {
            self.goalString = goal
        } else {
            self.goalString = "No goal set"
        }
    }
    
    //MARK:- computed properties
    var sum: Int {
        var s: Int = 0
        for c in choices {
            s += c.type.rawValue
        }
        return s
    }
    
    var numAllChoices: Int {
        //return choices.count - 1
        return choices.count
    }
    
    var numGoodChoices: Int {
        var c: Int = 0
        for i in choices {
            if i.type == .good {
                c += 1
            }
        }
        return c
    }
    
    var numBadChoices: Int {
        var c: Int = 0
        for i in choices {
            if i.type == .bad {
                c += 1
            }
        }
        return c
    }
    
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
    func goodChoice(note: String) {
        choices.append(Choice.init(choiceType: .good, note: note))
    }
    
    func badChoice(note: String) {
        choices.append(Choice.init(choiceType: .bad, note: note))
    }

    func changeGoal(_ newGoal: String) {
        goalString = newGoal
    }
}





