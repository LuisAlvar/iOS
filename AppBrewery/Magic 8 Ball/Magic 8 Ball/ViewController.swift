//
//  ViewController.swift
//  Magic 8 Ball
//
//  Created by Angela Yu on 14/06/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    
    let aryImageSource = [UIImage(resource: ImageResource.ball1),
                          UIImage(resource: ImageResource.ball2),
                          UIImage(resource: ImageResource.ball3),
                          UIImage(resource: ImageResource.ball4),
                          UIImage(resource: ImageResource.ball5)]
    
    // At start
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.image = UIImage(resource: ImageResource.ball1)
    }
    
    @IBAction func askButtonPressed(_ sender: Any) {
        imageView.image = aryImageSource.randomElement();
    }
    
}

