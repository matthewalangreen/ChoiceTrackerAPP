//
//  DailyRecordStore.swift
//  ChoiceTrackerAPP
//
//  Created by Matt Green on 8/16/18.
//  Copyright © 2018 Matt Green. All rights reserved.
//

import UIKit

class DailyRecordStore: Codable {
    //MARK:- Properties
    var allDailyRecords: Dictionary = [String:DailyRecordV2]()
    
    let recordsArchiveURL: URL = {
        let documentsDirectories = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        var documentDirectory = documentsDirectories.first!
        return documentDirectory.appendingPathComponent("dailyRecords.archive")
    }()
    
    //MARK:- Initializer
    init() {
//        if let archivedItems = NSKeyedUnarchiver.unarchiveObject(withFile: recordsArchiveURL.path) as? [String:DailyRecordV2] {
//            allDailyRecords = archivedItems
//        }
        
        guard let data = NSKeyedUnarchiver.unarchiveObject(withFile: recordsArchiveURL.path) as? Data else { return }
        do {
            let records = try PropertyListDecoder().decode([String:DailyRecordV2].self, from: data)
            allDailyRecords = records
            print("data retrieved")
        } catch {
            print("Could not retrieve records")
        }
    }
    
    //Mark:- Methods
    @discardableResult func createRandomDailyRecord() -> DailyRecordV2 {
        let n = Int(arc4random_uniform(3600)) // random number  0 - 49
        let nowDateString = sortableShortDate.string(from: generateRandomDate(daysBack: n)!)
        let newDailyRecord = DailyRecordV2.init(nowDateString: nowDateString)
        allDailyRecords[nowDateString] = newDailyRecord
        return newDailyRecord
    }
    
    @discardableResult func createDailyRecord() -> DailyRecordV2 {
       // let nowDateString = dateFormatter.string(from: Date.init())
        let nowDateString = sortableShortDate.string(from: Date.init())
       // let nowDate = Date.init()
        let newDailyRecord = DailyRecordV2.init(nowDateString: nowDateString, firstTimeToday: true)
        allDailyRecords[nowDateString] = newDailyRecord
        return newDailyRecord
    }
    
    
    //MARK:- NSCoding Methods
   @discardableResult func saveChanges() -> Bool {
        print("Saving items to: \(recordsArchiveURL.path)")
        do {
           let data = try PropertyListEncoder().encode(allDailyRecords)
            let success = NSKeyedArchiver.archiveRootObject(data, toFile: recordsArchiveURL.path)
            print(success ? "All data saved" : "Save Failed")
            return success
        } catch {
            print("Save Failed")
            return false
        }
    }
    
    //MARK:- Delete All Records
    func deleteAllRecords() {
        // erase all data
        allDailyRecords = [String:DailyRecordV2]()
        createDailyRecord()
    }
}



