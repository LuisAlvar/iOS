//
//  ViewController.swift
//  Tipsy
//
//  Created by Angela Yu on 09/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    /// This is the most widely used method because it wokrs in any layout and doesnt interfeere with other controls.
    @objc func dismissKeyboard() {
        // This tells the entier view hierarchy to resign the first repsponder, which closes the decimal pad.
        view.endEditing(true)
    }


}

