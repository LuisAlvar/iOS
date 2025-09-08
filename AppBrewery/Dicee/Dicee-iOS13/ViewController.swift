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
    var currentImageIndex = 0;
    
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
        DisplayDices()
    }

    @IBAction func rollButtonPressed(_ sender: UIButton) {
        // print("Button got tapped.");
        ShuffleTypeEffect()
        DisplayDices()
    }
    
    func ShuffleTypeEffect()
    {
        var prevIndexForDiceImage1 = 0
        var prevIndexForDiceImage2 = 0
        var currIndexForDiceImage1 = Int.random(in: 0...arryImages.count-1)
        var currIndexForDiceImage2 = Int.random(in: 0...arryImages.count-1)
        
        let maxCounter: Int = 3
        var iterationCounter: Int = 0
        
        Timer.scheduledTimer(withTimeInterval: 0.3, repeats: true) { timer in
            if iterationCounter >= maxCounter {
                timer.invalidate()
                return
            }
            
            while currIndexForDiceImage1 == prevIndexForDiceImage1 {
                currIndexForDiceImage1 = Int.random(in: 0...self.arryImages.count-1)
            }
            
            while currIndexForDiceImage2 == prevIndexForDiceImage2 {
                currIndexForDiceImage2 = Int.random(in: 0...self.arryImages.count-1)
            }
            
            self.diceImageView1.image = self.arryImages[currIndexForDiceImage1]
            self.diceImageView2.image = self.arryImages[currIndexForDiceImage2]
            
            prevIndexForDiceImage1 = currIndexForDiceImage1
            prevIndexForDiceImage2 = currIndexForDiceImage2
            
            iterationCounter += 1
        }
    }
    
    // Randomizing the ImageViews
    func DisplayDices() {
        diceImageView1.image = arryImages[Int.random(in: 0...arryImages.count-1)];
        diceImageView2.image = arryImages[Int.random(in: 0...arryImages.count-1)];
    }
}

