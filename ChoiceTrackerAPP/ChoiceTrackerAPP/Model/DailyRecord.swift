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
    var notes: [String] // new model
    var dateString: String   // encode using "sortableShortDate" closure
    var goalString: String
    
    //MARK:- init
    override init() {
        self.choices = genRandomData(40)
        self.notes = [String]() // new model
        self.dateString = sortableShortDate.string(from: Date.init())
        if let goal = UserDefaults.standard.string(forKey: "dataLabel") {
            self.goalString = goal
        } else {
            self.goalString = "No goal set"
        }
        
    }
    
    init(nowDateString: String) {
        self.dateString = nowDateString
        self.choices = genRandomData(40)
        self.notes = [String]() // new model
        if let goal = UserDefaults.standard.string(forKey: "dataLabel") {
            self.goalString = goal
        } else {
            self.goalString = "No goal set"
        }
    }
    
    init(nowDateString: String, firstTimeToday: Bool) {
        self.dateString = nowDateString
        self.notes = [String]() // new model
        if firstTimeToday {
            self.choices = [0]
        } else {
            self.choices = genRandomData(40)
        }
        if let goal = UserDefaults.standard.string(forKey: "dataLabel") {
            self.goalString = goal
        } else {
            self.goalString = "No goal set"
        }
    }
    
    //MARK:- NSCoding required methods
    func encode(with aCoder: NSCoder) {
        aCoder.encode(choices, forKey: "choices")
        aCoder.encode(dateString, forKey: "dateString")
        aCoder.encode(goalString, forKey: "goalString")
        aCoder.encode(notes, forKey: "notes") // new model
    }
    
    required init(coder aDecoder: NSCoder) {
        choices = aDecoder.decodeObject(forKey: "choices") as! [Int]
        dateString = aDecoder.decodeObject(forKey: "dateString") as! String
        goalString = aDecoder.decodeObject(forKey: "goalString") as! String
        notes = aDecoder.decodeObject(forKey: "notes") as! [String] // new model
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
        // add new model
    }
    
    func badChoice() {
        choices.append(-1)
        // add new model
    }
    
    func addChoiceNote(note: String) {
        notes.append(note)
    }
    
    func getNotes() -> [String] {
        return notes
    }
    
    func changeGoal(_ newGoal: String) {
        goalString = newGoal
    }
}





