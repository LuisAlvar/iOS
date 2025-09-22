//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//
/*
 This app lets users choose how they like their boiled eggs - soft, medium, or hard - and then
 starts a countdown timer based on the selected hardness. A progress bar visually tracks the
 boiling time, and an alarm sound plays whent he timer finishes. The app uses UIKit for the
 interface and AVFoundation for autio playback.
 */
import UIKit        // Import UIKit for UI Components
import AVFoundation // Import AVFoundation for audio playback

class ViewController: UIViewController {
    // Dictionary mapping egg hardness to boiling time in minutes
    let boilTimes = ["soft": 5, "medium": 7, "hard": 12]
    // Variables to track countdown time and total time in seconds
    var amountOfCountDown : Int = 0
    var totalTime : Int = 0
    // Timer object to handle countdown
    var timer : Timer?
    // Audio player to play alarm sound
    var player : AVAudioPlayer?
    
    // UI label to display current status or selection
    @IBOutlet weak var TitleLabel: UILabel!
    // Progress bar to visually show timer progress
    @IBOutlet weak var TimerProgressView: UIProgressView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Set initial progress bar to full
        TimerProgressView.progress = 1.0
        // Set initial label text
        TitleLabel.text = "How do you like your eggs?"
    }
    
    // Action triggered when a hardness button is pressed
    @IBAction func hardnessSelected(_ sender: Any) {
        // If a timer is already running, stop it
        if (timer != nil) {
            timer!.invalidate()
        }
        // Reset progress bar to full
        TimerProgressView.progress = 1.0
        // Cast sender to UIButton to access its properties
        let btnPressed: UIButton = sender as! UIButton
        // Get the button's title and convert it to lowercase
        let btnTextData: String  = (btnPressed.titleLabel?.text ?? "").lowercased()
        // Update label to show seleted hardness
        TitleLabel.text = btnPressed.titleLabel?.text!
        
        // Get boiling time from dictionary, default to 0 if not found
        let minBoilTime = boilTimes[btnTextData] ?? 0
        print(minBoilTime) // Debug print
        
        // Convert minutes to seconds for countdown
        amountOfCountDown = ConvertMinutesToSeconds(time: minBoilTime)
        
        // Store total time for progress calculations
        totalTime = amountOfCountDown
        print(amountOfCountDown) // Debug print
        
        // Start the countdown timer, tirggering every second
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(TimeUpdate), userInfo: nil, repeats: true)
    }
    
    // Function called every second by the timer (objective-c)
    @objc func TimeUpdate() {
        if (amountOfCountDown > 0)
        {
            // Decrease countdown by 1 second
            amountOfCountDown -= 1
            // Print reaming time for debugging
            print(String(amountOfCountDown) + " seconds.")
            // Calculate progress as a float between 0 and 1
            let currentProgress = 1.0 - Float(amountOfCountDown) / Float(totalTime)
            print(currentProgress) // Debug print
            
            // Update progress bar
            TimerProgressView.progress = Float(currentProgress)
            TimerProgressView.setProgress(TimerProgressView.progress, animated: true)
        }
        else
        {
            // Stop the timer when countdown reaches zero
            timer!.invalidate();
            // Update label to show completion
            TitleLabel.text = "DONE!"
            // Play alarm sound
            playTimerSound()
        }
    }
    
    // Helper function to convert minutes to seconds
    func ConvertMinutesToSeconds(time: Int) -> Int {
        return time * 60;
    }

    // Helper function to play alarm sound when timer finishes
    func playTimerSound()
    {
        // Locate the alarm sound file in the app bundle
        guard let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3") else { return }
        
        do {
            // Configure audio session for playback
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
            
            // Initialize audio player with the sound file
            player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)
            
            // Ensure player is valid before playing
            guard let player = player else { return }
            
            // Play the alarm sound
            player.play()
        } catch let error {
            // Print any errors that occur during setup or playback
            print(error.localizedDescription)
        }
    }
    
}
