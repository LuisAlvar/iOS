//
//  ResultViewController.swift
//  Tipsy
//
//  Created by Luis Alvarez on 12/30/25.
//  Copyright © 2025 The App Brewery. All rights reserved.
//

import UIKit

class ResultViewController: UIViewController {

    var calculatedAmountPerPerson: String = ""
    var tipPercentage: String = ""
    var numberOfPeople: String = ""
    
    @IBOutlet weak var amountPerPersonLabel: UILabel!
    @IBOutlet weak var amountInfoLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        amountPerPersonLabel.text = "$\(calculatedAmountPerPerson)"
        amountInfoLabel.text = "Split between \(numberOfPeople) people with a \(tipPercentage)% tip."
    }
    
    @IBAction func recalculatePressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
