//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    let boilTimes = ["soft": 5, "medium": 7, "hard": 12]
    var amountOfCountDown : Int = 0
    var totalTime : Int = 0
    var timer : Timer?
    var player : AVAudioPlayer?
    
    @IBOutlet weak var TitleLabel: UILabel!
    @IBOutlet weak var TimerProgressView: UIProgressView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        TimerProgressView.progress = 1.0
        TitleLabel.text = "How do you like your eggs?"
    }
    
    @IBAction func hardnessSelected(_ sender: Any) {
        
        if (timer != nil) {
            timer!.invalidate()
        }
        
        TimerProgressView.progress = 1.0
        let btnPressed: UIButton = sender as! UIButton
        let btnTextData: String  = (btnPressed.titleLabel?.text ?? "").lowercased()
        
        TitleLabel.text = btnPressed.titleLabel?.text!
    
        let minBoilTime = boilTimes[btnTextData] ?? 0
        print(minBoilTime)
        
        amountOfCountDown = ConvertMinutesToSeconds(time: minBoilTime)
        totalTime = amountOfCountDown
        print(amountOfCountDown)
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(TimeUpdate), userInfo: nil, repeats: true)
        
    }
    
    @objc func TimeUpdate() {
        if (amountOfCountDown > 0)
        {
            amountOfCountDown -= 1
            print(String(amountOfCountDown) + " seconds.")
            let currentProgress = 1.0 - Float(amountOfCountDown) / Float(totalTime)
            print(currentProgress)
            TimerProgressView.progress = Float(currentProgress)
            TimerProgressView.setProgress(TimerProgressView.progress, animated: true)
        }
        else
        {
            timer!.invalidate();
            TitleLabel.text = "DONE!"
            playTimerSound()
        }
    }
    
    func ConvertMinutesToSeconds(time: Int) -> Int {
        return time * 60;
    }

    func playTimerSound()
    {
        guard let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3") else { return }
        
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
            
            player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)
            
            guard let player = player else { return }
            
            player.play()
            
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
}
