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
    var allDailyRecords: Dictionary = [String:DailyRecord]()
    
    let recordsArchiveURL: URL = {
        let documentsDirectories = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        var documentDirectory = documentsDirectories.first!
        return documentDirectory.appendingPathComponent("dailyRecords.archive")
    }()
    
    //MARK:- Initializer
    init() {
        if let archivedItems = NSKeyedUnarchiver.unarchiveObject(withFile: recordsArchiveURL.path) as? [String:DailyRecord] {
            allDailyRecords = archivedItems
        }
    }
    
    //Mark:- Methods
    @discardableResult func createRandomDailyRecord() -> DailyRecord {
        let n = Int(arc4random_uniform(3600)) // random number  0 - 49
        let nowDateString = sortableShortDate.string(from: generateRandomDate(daysBack: n)!)
        let newDailyRecord = DailyRecord.init(nowDateString: nowDateString)
        allDailyRecords[nowDateString] = newDailyRecord
        return newDailyRecord
    }
    
    @discardableResult func createDailyRecord() -> DailyRecord {
       // let nowDateString = dateFormatter.string(from: Date.init())
        let nowDateString = sortableShortDate.string(from: Date.init())
       // let nowDate = Date.init()
        let newDailyRecord = DailyRecord.init(nowDateString :nowDateString, firstTimeToday: true)
        allDailyRecords[nowDateString] = newDailyRecord
        return newDailyRecord
    }
    
    
    //MARK:- NSCoding Methods
    func saveChanges() -> Bool {
        print("Saving items to: \(recordsArchiveURL.path)")
        return NSKeyedArchiver.archiveRootObject(allDailyRecords, toFile: recordsArchiveURL.path)
    }
}



