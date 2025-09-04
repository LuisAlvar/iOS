//
//  ViewController.swift
//  Dicee-iOS13
//
//  Created by Angela Yu on 11/06/2019.
//  Copyright © 2019 London App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var diceImageView1: UIImageView!
    @IBOutlet weak var diceImageView2: UIImageView!
    
    // Our constant data source
    let arryImages = [UIImage(resource: ImageResource.diceOne),
                      UIImage(resource: ImageResource.diceTwo),
                      UIImage(resource: ImageResource.diceThree),
                      UIImage(resource: ImageResource.diceFour),
                      UIImage(resource: ImageResource.diceFive),
                      UIImage(resource: ImageResource.diceSix)]
    
    // method executed at startup
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        DisplayDices();
    }

    @IBAction func rollButtonPressed(_ sender: UIButton) {
        // print("Button got tapped.");
        DisplayDices();
    }
    
    // Randomizing the ImageViews
    func DisplayDices() {
        diceImageView1.image = arryImages[Int.random(in: 0...arryImages.count-1)];
        diceImageView2.image = arryImages[Int.random(in: 0...arryImages.count-1)];
    }

    
}

