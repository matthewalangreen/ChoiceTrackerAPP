//
//  MainVC.swift
//  TestPurchases
//
//  Created by Matt Green on 9/29/18.
//  Copyright © 2018 Matt Green. All rights reserved.
//

import UIKit

class MainVC: UIViewController {
    //MARK:- IBActions
    @IBAction func getConsumable(_ sender: Any) {
        IAPService.shared.purchase(product: .consumable)
    }
    
    @IBAction func getNonConsumable(_ sender: Any) {
        IAPService.shared.purchase(product: .nonConsumable)
    }
    
    @IBAction func getAutoRenewMonthly(_ sender: Any) {
        IAPService.shared.purchase(product: .autoRenewMonthly)
    }
    
    @IBAction func getAutoRenewYearly(_ sender: Any) {
       IAPService.shared.purchase(product: .autoRenewYearly)
    }
    
    @IBAction func restorePurchases(_ sender: Any) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        IAPService.shared.getProducts()
    }
    
}
