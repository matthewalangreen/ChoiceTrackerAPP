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

//MARK:- Alert with field
func alertWithField(dailyRecord: DailyRecord) -> UIAlertController {
    var userGoalField: UITextField?
    
    // 2.
    let alertController = UIAlertController(
        title: "What happened?",
        message: "Write a note to describe the choice",
        preferredStyle: UIAlertController.Style.alert)
    
    // 3.
    let goalAction = UIAlertAction(title: "Add Note", style: .default) {
        (action) -> Void in
        
        if let newGoal = userGoalField?.text {
            // set the goal to the match the text entered
//            currentDailyRecord.changeGoal(newGoal)
//            UserDefaults.standard.set(newGoal, forKey: "dataLabel")
            userGoalField?.autocorrectionType = .yes
            userGoalField?.autocapitalizationType = .sentences
            dailyRecord.addChoiceNote(note: newGoal)
            
        } else {
            print("no note added")
        }
    }
    
    // 4.
    alertController.addTextField {
        (userGoal) -> Void in
        userGoalField = userGoal
        userGoalField!.placeholder = "Placeholder text"
    }
    
    let noAction = UIAlertAction(title: "Cancel", style: .destructive, handler: nil)
    
    // 5.
    alertController.addAction(noAction)
    alertController.addAction(goalAction)
    alertController.view.tintColor = UIColor.init(named: "light-good")
    
    return alertController
    //present(alertController, animated: true, completion: nil)
}

func changeGoalAlert(currentDailyRecord: DailyRecord) -> UIAlertController {
    var userGoalField: UITextField?
    
    // 2.
    let alertController = UIAlertController(
        title: "Set Goal",
        message: "What are you focused on today?",
        preferredStyle: UIAlertController.Style.alert)
    
    // 3.
    let goalAction = UIAlertAction(title: "Set Goal", style: .default) {
        (action) -> Void in
        
        if let newGoal = userGoalField?.text {
            // set the goal to the match the text entered
            currentDailyRecord.changeGoal(newGoal)
            UserDefaults.standard.set(newGoal, forKey: "dataLabel")
            
        } else {
            print("no goal entered")
        }
    }
    
    // 4.
    alertController.addTextField {
        (userGoal) -> Void in
        userGoalField = userGoal
        userGoalField!.placeholder = currentDailyRecord.goalString
        userGoalField?.autocorrectionType = .yes
        userGoalField?.autocapitalizationType = .sentences
    }
    
    let noAction = UIAlertAction(title: "Cancel", style: .destructive, handler: nil)
    
    // 5.
    alertController.addAction(noAction)
    alertController.addAction(goalAction)
    alertController.view.tintColor = UIColor.init(named: "light-good")
    
    return alertController
    //present(alertController, animated: true, completion: nil)
}

func changeGoalAlertWithHandler(currentDailyRecord: DailyRecord, handler: @escaping ()->()) -> UIAlertController {
    var userGoalField: UITextField?
    
    // 2.
    let alertController = UIAlertController(
        title: "Set Goal",
        message: "What are you focused on today?",
        preferredStyle: UIAlertController.Style.alert)
    
    // 3.
    let goalAction = UIAlertAction(title: "Set Goal", style: .default) {
        (action) -> Void in
        
        if let newGoal = userGoalField?.text {
            // set the goal to the match the text entered
            currentDailyRecord.changeGoal(newGoal)
            UserDefaults.standard.set(newGoal, forKey: "dataLabel")
            handler()
            
        } else {
            print("no goal entered")
        }
    }
    
    // 4.
    alertController.addTextField {
        (userGoal) -> Void in
        userGoalField = userGoal
        userGoalField!.placeholder = currentDailyRecord.goalString
    }
    
    let noAction = UIAlertAction(title: "Cancel", style: .destructive, handler: nil)
    
    // 5.
    alertController.addAction(noAction)
    alertController.addAction(goalAction)
    alertController.view.tintColor = UIColor.init(named: "light-good")
    return alertController
    //present(alertController, animated: true, completion: nil)
}







