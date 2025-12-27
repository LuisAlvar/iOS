//
//  ViewController.swift
//  BMI-Calculator-LayoutPractice
//
//  Created by Angela Yu on 21/08/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit
import Foundation

class ViewController: UIViewController {
    
    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    
    @IBOutlet weak var weightSlider: UISlider!
    @IBOutlet weak var heightSlider: UISlider!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func heightSliderChanged(_ sender: UISlider) {
        // use sender.value to fetch the UI element's value
        let value = String(format: "%.2f", sender.value)
        print(value)
        heightLabel.text = "\(value)m"
    }
    
    @IBAction func weightSliderChanged(_ sender: UISlider) {
        // use sender.value to fetch the UI element's value
        let value = String(format: "%.0f", sender.value)
        print(value)
        weightLabel.text = "\(value)kg"
    }
    
    @IBAction func calculatePressed(_ sender: UIButton) {
        let weight: Float = trunc(weightSlider.value)
        let height: Float = round(heightSlider.value*100)/100
        print("Weight: \(weight), Height: \(height)")
        let bmi = (weight/(height*height))
        print("BMI is \(String(format:"%.2f", bmi))")
    }
    
}

