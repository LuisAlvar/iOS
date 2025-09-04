//
//  ViewController.swift
//  Xylophone
//
//  Created by Angela Yu on 28/06/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    var player: AVAudioPlayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func keyPressed(_ sender: Any) {
        Task { @MainActor in
            let rtButton: UIButton = sender as! UIButton
            let rtBtnTextData: String = rtButton.currentTitle!
            
            rtButton.alpha = 0.5
            print("Start")
            await asyncSound(soundName: rtBtnTextData)
            print("End")
            rtButton.alpha = 1
        }
    }
    
    func asyncSound(soundName: String) async {
        do {
            try await Task.sleep(nanoseconds: 200000000)
        } catch let error {
            print(error.localizedDescription)
        }
        playSound(soundType: soundName)
    }

    func playSound(soundType: String)
    {
        if (soundType == "") {
            return
        }
        
        guard let url = Bundle.main.url(forResource: soundType, withExtension: "wav") else { return }
        
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance()
                .setActive(true)
            
            player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.wav.rawValue)
            
            guard let player = player else { return }
            
            player.play()
            
        } catch let error {
            print(error.localizedDescription)
        }
    }
}
