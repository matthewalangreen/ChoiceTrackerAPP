////
////  CustomAlert.swift
////  ChoiceTrackerAPP
////
////  Created by Matt Green on 9/18/18.
////  Copyright © 2018 Matt Green. All rights reserved.
////
//
//import UIKit
//
//class CustomAlert() -> UIAlertController {
//    
//    var userGoalField: UITextField?
//    
//    // 2.
//    let alertController = UIAlertController(
//        title: "Set Goal",
//        message: "What are you focused on today?",
//        preferredStyle: UIAlertControllerStyle.alert)
//    
//    // 3.
//    let goalAction = UIAlertAction(title: "Set Goal", style: .destructive) {
//        (action) -> Void in
//        
//        if let newGoal = userGoalField?.text {
//            // set the goal to the match the text entered
//            self.currentDailyRecord.changeGoal(newGoal)
//            
//        } else {
//            print("no goal entered")
//        }
//    }
//    
//    // 4.
//    alertController.addTextField {
//    (userGoal) -> Void in
//    userGoalField = userGoal
//    userGoalField!.placeholder = self.currentDailyRecord.goalString
//    }
//    
//    let noAction = UIAlertAction(title: "Cancel", style: .default, handler: nil)
//    
//    // 5.
//    alertController.addAction(goalAction)
//    alertController.addAction(noAction)
//    self.present(alertController, animated: true, completion: nil)
//    
//    
//}
