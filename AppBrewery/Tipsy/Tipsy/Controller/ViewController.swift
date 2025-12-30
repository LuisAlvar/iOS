//
//  ViewController.swift
//  Tipsy
//
//  Created by Angela Yu on 09/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var amountTextField: UITextField!
    @IBOutlet weak var splitNumberLabel: UILabel!
    
    @IBOutlet weak var firstTipOption: UIButton!
    @IBOutlet weak var secondTipOption: UIButton!
    @IBOutlet weak var thirdTipOption: UIButton!
        
    var tipCalculator = TipCalculator()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @IBAction func selectedTipPressed(_ sender: UIButton) {
        print("Selected Tip: \(sender.titleLabel?.text ?? "No Tip Selected")")
        // Ensure only one tip option is selected at a time
        // Determine which index was tapped based on the button instance
        if sender === firstTipOption {
            firstTipOption.isSelected = true
            secondTipOption.isSelected = false
            thirdTipOption.isSelected = false
        } else if sender === secondTipOption {
            firstTipOption.isSelected = false
            secondTipOption.isSelected = true
            thirdTipOption.isSelected = false
        } else if sender === thirdTipOption {
            firstTipOption.isSelected = false
            secondTipOption.isSelected = false
            thirdTipOption.isSelected = true
        }
        let tip = Double(sender.titleLabel!.text!.split(separator: "%")[0]) ?? 0
        print("tip: \(tip/100)")
        tipCalculator.setTipPercentage(TipPercentage: tip/100)
    }
    
    @IBAction func splitNumberPressed(_ sender: UIStepper) {
        print("Split Number Stepper: \(sender.value)")
        let int = Int(sender.value)
        splitNumberLabel.text = "\(int)"
        tipCalculator.setWaysBillSplit(WaysBillSplit: int)
    }
    
    @IBAction func calculatePressed(_ sender: UIButton) {
        if let amount = amountTextField.text, let amt = Double(amount) {
            print("Amount: \(amt)")
            tipCalculator.setAmount(Amount: amt)
            self.performSegue(withIdentifier: "goToResult", sender: self)
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToResult" {
            
            let destinationVC = segue.destination as! ResultViewController
            destinationVC.calculatedAmountPerPerson = String(format: "%.2f",tipCalculator.amountCalculatedPerPerson())
            destinationVC.numberOfPeople = "\(tipCalculator.waysBillSplit)"
            destinationVC.tipPercentage = "\(Int(tipCalculator.tipPercentage*100))"
        }
    }
    
    
    /// This is the most widely used method because it wokrs in any layout and doesnt interfeere with other controls.
    @objc func dismissKeyboard() {
        // This tells the entier view hierarchy to resign the first repsonder, which closes the decimal pad.
        view.endEditing(true)
    }


}

