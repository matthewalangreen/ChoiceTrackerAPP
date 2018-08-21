////: Playground - noun: a place where people can play
//
import UIKit
//
////Mark:- Methods
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
//
//let dateFormatter: DateFormatter = {
//    let formatter = DateFormatter()
//    formatter.dateStyle = .medium
//    formatter.timeStyle = .none
//    formatter.locale = Locale(identifier: "en_US")
//    return formatter
//}()
//
//
// let nowDateString = dateFormatter.string(from: generateRandomDate(daysBack: 10)!)
//
//
//func makeRandomDateStringDict() -> [Date:Int] {
//    var stringDict = [Date:Int]()
//    for _ in 0..<40 {
//        let date = generateRandomDate(daysBack: 1000)!
//        stringDict[date] = 12
//    }
//    return stringDict
//}
//
//let test = makeRandomDateStringDict()
//
//
//let sortedKeysAndValues = test.sorted(by: { $0.0 < $1.0} )
//sortedKeysAndValues[1].key
//
//
//




//

//
//
//let now: Date = Date.init()
//let otherDate: Date = generateRandomDate(daysBack: 10)!
//
//let nowString: String = df2.string(from: now)
//let otherString: String = df2.string(from: otherDate)
//
//nowString < otherString
//
//let _nowString: String = dateFormatter.string(from: now)
//let _otherString: String = dateFormatter.string(from: otherDate)
//
//_nowString > _otherString
//
//nowString
//otherString
//
//nowString < otherString



//func makeDateDictionary() -> [Date:String] {
//    var count = 0;
//    var dict = [Date:String]()
//
//    for _ in 0..<40 {
//        count += 1
//        dict[generateRandomDate(daysBack: 1000)!] = "hi"
//    }
//    return dict
//}


// dateFormatter
let prettyDateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .medium
    formatter.timeStyle = .none
    formatter.locale = Locale(identifier: "en_US")
    return formatter
}()

let sortableShortDate: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd"
    formatter.locale = Locale(identifier: "en_US")
    return formatter
}()




var testDateDict =  [String:String]()
testDateDict[sortableShortDate.string(from: generateRandomDate(daysBack: 1000)!)] = "1"
testDateDict[sortableShortDate.string(from: generateRandomDate(daysBack: 1000)!)] = "2"
testDateDict[sortableShortDate.string(from: generateRandomDate(daysBack: 1000)!)] = "3"
testDateDict[sortableShortDate.string(from: generateRandomDate(daysBack: 1000)!)] = "4"
testDateDict[sortableShortDate.string(from: generateRandomDate(daysBack: 1000)!)] = "5"

// get a date that is in a sortable format
let testDate = [String](testDateDict.keys)[1]

//convert that back into a Date object
let date = sortableShortDate.date(from: testDate)!

// covert that date format into a "pretty" format to show user
let prettyDate = prettyDateFormatter.string(from: date)


//for k in testDateDict.keys {
//    print("keys?: \(k)")
//}
//
//for v in testDateDict.values {
//    print("values?: \(v)")
//}


let sortedStuff = testDateDict.sorted(by: { $0.0 < $1.0 } )

for i in sortedStuff {
    print("item: \(i)")
}

print("_+__+_+__+_+__+_+_+_+_+__+_+_+__+_+_+_+__+__+__+_+_+__+_+_+_+_+_+_")

for i in testDateDict {
    print("item: \(i)")
}

























