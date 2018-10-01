//
//  AboutViewController.swift
//  ChoiceTrackerAPP
//
//  Created by Matt Green on 9/2/18.
//  Copyright © 2018 Matt Green. All rights reserved.
//

import UIKit

class AboutViewController: UIViewController {
    //MARK:- IBOutlets
    @IBOutlet var bgView: UIView!
    @IBOutlet var aboutTextView: UITextView!
    @IBOutlet var logoImage: UIImageView!
    
    //MARK:- Force Portrait
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        bgView.backgroundColor = Theme.current.backgroundColor
        aboutTextView.textColor = Theme.current.textColor
        // set logo image
        logoImage.image = UIImage.init(named: Theme.current.logoImage)
        
        AppUtility.lockOrientation(.portrait)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
  
        // Don't forget to reset when view is being removed
        AppUtility.lockOrientation(.all)
    }
 
}

