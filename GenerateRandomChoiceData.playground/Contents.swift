//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"


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

genRandomData(40)
