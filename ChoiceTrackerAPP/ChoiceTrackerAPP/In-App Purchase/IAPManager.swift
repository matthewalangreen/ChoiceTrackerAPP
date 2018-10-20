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
            SKPaymentQueue.default().add(self)
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
    
    //MARK: SKProductsRequestDelegate
    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        self.products = response.products
        print("products: \(self.products)")
    }
    
    //MARK: SKPaymentObject
    func createPaymentReqeustForProduct(product: SKProduct) {
        let payment = SKMutablePayment(product: product)
        payment.quantity = 1
        
        SKPaymentQueue.default().add(payment)
    }
    
   
    
}

extension IAPManager: SKPaymentTransactionObserver {
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        //
        transactions.forEach { (transaction) in
            switch transaction.transactionState {
            case .purchasing:
                print("purchasing")
                break
            case .deferred:
                print("deffered")
                break
            case .failed:
                print("failed \(transaction.error?.localizedDescription ?? "No error returned")")
                SKPaymentQueue.default().finishTransaction(transaction)
                break
            case .purchased:
                print("purchased")
                SKPaymentQueue.default().finishTransaction(transaction)
                break
            case .restored:
                print("restored")
                break
            }
        }
    }
    
    func paymentQueue(_ queue: SKPaymentQueue, restoreCompletedTransactionsFailedWithError error: Error) {
        //
    }
    
    func paymentQueue(_ queue: SKPaymentQueue, removedTransactions transactions: [SKPaymentTransaction]) {
        //
    }
    
    func paymentQueue(_ queue: SKPaymentQueue, updatedDownloads downloads: [SKDownload]) {
        //
    }
    
    func paymentQueueRestoreCompletedTransactionsFinished(_ queue: SKPaymentQueue) {
        //
    }
    
    //MARK: Receipt Validation
    func validateReceipt(completion: @escaping (Bool) -> Void) {
        guard let receiptUrl = Bundle.main.appStoreReceiptURL, let receipt = try? Data(contentsOf: receiptUrl) else { return }
        
        
    }
}
