//: Playground - noun: a place where people can play

import Foundation

var str = "Hello, playground"
var dataDictionary: Dictionary = [String:DailyChoices]()

let dateFormatter = DateFormatter()
dateFormatter.dateStyle = .medium
dateFormatter.timeStyle = .none
dateFormatter.locale = Locale(identifier: "en_US")

let nowDateString = dateFormatter.string(from: Date.init())
let tomorrowDateString = dateFormatter.string(from: Date(timeIntervalSinceNow: 20000))

dataDictionary[nowDateString] = DailyChoices()
//dataDictionary[tomorrowDateString] = DailyChoices()

print(dataDictionary[nowDateString]!)

print(dataDictionary.keys)


// check to see if our dictionary has data for given day
func dataExistsFor(day: String) -> Bool {
    return dataDictionary.keys.contains(day)
}

if(dataExistsFor(day: nowDateString)) {
    print("There is data!")
}

// if dataExistsFor(day: today)
// then load that data and use it
// if not, then create a new item with today's date and use it.

// we just need to figure out how to store data


//
//var nDate = Date.init()
//print(nDate.description)
//
//var sDate = Date(timeIntervalSinceNow: 2000)
//print(sDate.description)
//var test = DailyChoices()
//

//
//let dateStringFirst: String = dateFormatter.string(from: nDate)
//print(dateStringFirst)
//let dateStringSecond: String  = dateFormatter.string(from: sDate)
//print(dateStringSecond)
//
//
//print(dateStringFirst == dateStringSecond)
//
//
//func findOrCreateDailyChoices() {
//    let nowDate = Date.init()
//    let dFormat = DateFormatter()
//    dFormat.dateStyle = .medium
//    dFormat.timeStyle = .none
//    dFormat.locale = Locale(identifier: "en_US")
//
//
//}


