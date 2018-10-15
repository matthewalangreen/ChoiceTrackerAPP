//
//  IAPService.swift
//  ChoiceTrackerAPP
//
//  Created by Matt Green on 10/14/18.
//  Copyright © 2018 Matt Green. All rights reserved.
//

import Foundation
import StoreKit

class IAPService: NSObject {
    
    private override init() {} // can't create an instance, must use singleton
    static let shared = IAPService() // singleton
    
    var products = [SKProduct]()
    let paymentQueue = SKPaymentQueue.default()
    
    func getProducts() {
        let products: Set = [IAPProduct.autoRenewMonthly.rawValue,
                             IAPProduct.autoRenewYearly.rawValue,
                             IAPProduct.consumable.rawValue,
                             IAPProduct.nonConsumable.rawValue]
        
        let request = SKProductsRequest(productIdentifiers: products)
        request.delegate = self // SKProductsRequestDelegate
        request.start()
        paymentQueue.add(self) // SKPaymentTransactionObserver
    }
    
    func purchase(product: IAPProduct) {
        guard let productToPurchase = products.filter({ $0.productIdentifier == product.rawValue}).first
            else { return }
        let payment = SKPayment(product: productToPurchase)
        // stores all info about transacation for users purchase history. Stuff stored here
        // when you make, restore or are puchasing. Stays in queue until purchase is resolved
        // the queue is cleared. We will referene this a lot.
        paymentQueue.add(payment)
    }
}

extension IAPService: SKProductsRequestDelegate {
    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        self.products = response.products
        for product in response.products {
            print(product.productIdentifier)
        }
    }
}

extension IAPService: SKPaymentTransactionObserver {
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        // See what's happening with the transaction
        for transaction in transactions {
            print(transaction.transactionState)
            print(transaction.transactionState.status(), transaction.payment.productIdentifier)
        }
    }
    
}

// helps us make sense out of what's going on with the transcation codes
extension SKPaymentTransactionState {
    func status() -> String {
        switch self {
        case .deferred: return "deffered"
        case .failed: return "failed"
        case .purchased: return "purchased"
        case .purchasing: return "purchasing"
        case .restored: return "restored"
        }
    }
}



