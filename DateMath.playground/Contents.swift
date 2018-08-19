//: Playground - noun: a place where people can play

import UIKit

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

let dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .medium
    formatter.timeStyle = .none
    formatter.locale = Locale(identifier: "en_US")
    return formatter
}()


 let nowDateString = dateFormatter.string(from: generateRandomDate(daysBack: 10)!)


func makeRandomDateStringDict() -> [Date:Int] {
    var stringDict = [Date:Int]()
    for _ in 0..<40 {
        let date = generateRandomDate(daysBack: 1000)!
        stringDict[date] = 12
    }
    return stringDict
}

let test = makeRandomDateStringDict()


let sortedKeysAndValues = test.sorted(by: { $0.0 < $1.0} )
sortedKeysAndValues[1].key



