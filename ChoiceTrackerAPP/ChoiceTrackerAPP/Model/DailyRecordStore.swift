//
//  DailyRecordStore.swift
//  ChoiceTrackerAPP
//
//  Created by Matt Green on 8/16/18.
//  Copyright © 2018 Matt Green. All rights reserved.
//

import UIKit

class DailyRecordStore{
    //MARK:- Properties
    var allDailyRecords: Dictionary = [Date:DailyRecord]()
    
    let recordsArchiveURL: URL = {
        let documentsDirectories = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        var documentDirectory = documentsDirectories.first!
        return documentDirectory.appendingPathComponent("dailyRecords.archive")
    }()
    
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        formatter.locale = Locale(identifier: "en_US")
        return formatter
    }()
    
    //MARK:- Initializer
    init() {
        if let archivedItems = NSKeyedUnarchiver.unarchiveObject(withFile: recordsArchiveURL.path) as? [Date:DailyRecord] {
            allDailyRecords = archivedItems
        }
    }
    
    //Mark:- Methods
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
    
    @discardableResult func createRandomDailyRecord() -> DailyRecord {
        let n = Int(arc4random_uniform(3600)) // random number  0 - 49
       // let nowDateString = dateFormatter.string(from: generateRandomDate(daysBack: n)!)
        let nowDate = generateRandomDate(daysBack: n)!
        let newDailyRecord = DailyRecord.init(nowDate: nowDate)
        allDailyRecords[nowDate] = newDailyRecord
        return newDailyRecord
    }
    
    @discardableResult func createDailyRecord() -> DailyRecord {
       // let nowDateString = dateFormatter.string(from: Date.init())
        let nowDate = Date.init()
        let newDailyRecord = DailyRecord.init(nowDate:nowDate, firstTimeToday: true)
        allDailyRecords[nowDate] = newDailyRecord
        return newDailyRecord
    }
    
    
    //MARK:- NSCoding Methods
    func saveChanges() -> Bool {
        print("Saving items to: \(recordsArchiveURL.path)")
        return NSKeyedArchiver.archiveRootObject(allDailyRecords, toFile: recordsArchiveURL.path)
    }
}



