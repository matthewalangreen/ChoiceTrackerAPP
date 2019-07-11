//
//  DailyRecordV2.swift
//  ChoiceTrackerAPP
//
//  Created by Matthew Green on 7/11/19.
//  Copyright © 2019 Matt Green. All rights reserved.
//


import UIKit

class Choice: NSObject {
    enum ChoiceType: Int {
        case good = 1
        case bad = -1
    }
    
    var type: ChoiceType
    var note: String
    
    override init() {
        type = .good
        note = ""
    }
    
    init(choiceType: ChoiceType, note: String) {
        self.type = choiceType
        self.note = note
    }
}

class DailyRecordV2: NSObject, NSCoding {
    
    //MARK:- properties
    var choices = [Choice]() //testing
    //var choices: [Choice]
    var dateString: String   // encode using "sortableShortDate" closure
    var goalString: String
    
    //MARK:- init
    override init() {
        //self.choices = genRandomData(40)
        self.choices = [Choice]()
        //self.notes = [String]() // new model
        self.dateString = sortableShortDate.string(from: Date.init())
        if let goal = UserDefaults.standard.string(forKey: "dataLabel") {
            self.goalString = goal
        } else {
            self.goalString = "No goal set"
        }
        
    }
    
    init(nowDateString: String) {
        self.dateString = nowDateString
        //self.choices = genRandomData(40)
        self.choices = [Choice]()
        //self.notes = [String]() // new model
        if let goal = UserDefaults.standard.string(forKey: "dataLabel") {
            self.goalString = goal
        } else {
            self.goalString = "No goal set"
        }
    }
    
    init(nowDateString: String, firstTimeToday: Bool) {
        self.dateString = nowDateString
        //self.notes = [String]() // new model
        if firstTimeToday {
            //TODO: This is the offending line in the model...
            //self.choices = [0]
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
    
    // https://stackoverflow.com/questions/48040763/how-do-i-encode-a-custom-class-object-using-userdefaults-that-has-a-variable-of
    //MARK:- NSCoding required methods
    func encode(with aCoder: NSCoder) {
        //aCoder.encode(choices, forKey: "choices") // crashing
        //aCoder.encode(NSKeyedArchiver.archivedData(withRootObject: choices), forKey: "choices")
        aCoder.encode(dateString, forKey: "dateString")
        aCoder.encode(goalString, forKey: "goalString")
    }
    

    required init(coder aDecoder: NSCoder) {
        //choices = aDecoder.decodeObject(forKey: "choices") as! [Choice]
        //choices = NSKeyedUnarchiver.unarchiveObject(with: (aDecoder.decodeObject(forKey: "choices") as! NSData) as Data) as! [Choice]
        dateString = aDecoder.decodeObject(forKey: "dateString") as! String
        goalString = aDecoder.decodeObject(forKey: "goalString") as! String
        super.init()
    }
    
    //MARK:- computed properties
    var sum: Int {
        var s: Int = 0
        for c in choices {
            s += c.type.rawValue
        }
        return s
        //return choices.reduce(0,+)
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
//
//        var count = 0
//        for item in choices {
//            if item == 1 {
//                count += 1
//            }
//        }
//        return count
    }
    
    var numBadChoices: Int {
        var c: Int = 0
        for i in choices {
            if i.type == .bad {
                c += 1
            }
        }
        return c
//        var count = 0
//        for item in choices {
//            if item == -1 {
//                count += 1
//            }
//        }
//        return count
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
        //choices.append(1)
        // add new model
    }
    
    func badChoice(note: String) {
        choices.append(Choice.init(choiceType: .bad, note: note))
        //choices.append(-1)
        // add new model
    }
    
//    func addChoiceNote(note: String) {
//        //notes.append(note)
//    }
//
//    func getNotes() -> [String] {
//        //return notes
//    }
    
    func changeGoal(_ newGoal: String) {
        goalString = newGoal
    }
}





