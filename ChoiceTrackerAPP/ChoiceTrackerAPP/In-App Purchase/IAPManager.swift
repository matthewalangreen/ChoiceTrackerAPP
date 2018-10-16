//
//  IAPManager.swift
//  ChoiceTrackerAPP
//
//  Created by Matt Green on 10/15/18.
//  Copyright © 2018 Matt Green. All rights reserved.
//

import UIKit
import StoreKit

class IAPManager: NSObject, SKProductsRequestDelegate {
    static let sharedInstance = IAPManager()
    
    var request: SKProductsRequest!
    var products: [SKProduct] = []
    
    func setupPurchases(_ completion: @escaping (Bool) -> Void) {
        // check if we can make payments
        if SKPaymentQueue.canMakePayments() {
            completion(true)
            return
        }
        
        completion(false)
    }
    
    func getProductIdentifiers() -> [String] {
        var identifiers: [String] = []
        
        if let fileURL = Bundle.main.url(forResource: "products", withExtension: "plist") {
    
            let products = NSArray(contentsOf: fileURL)!
            
            for product in products as! [String] {
                identifiers.append(product)
            }
        }
        
        return identifiers
    }
    
    func performProductRequestForIdentifiers(identifiers: [String]) {
        let products = NSSet(array: identifiers) as! Set<String>
        
        self.request = SKProductsRequest(productIdentifiers: products)
        self.request.delegate = self
        self.request.start()
    }
    
    //MARK:- SKProductsRequestDelegate
    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        self.products = response.products
        print("products: \(self.products)")
    }
    
}
