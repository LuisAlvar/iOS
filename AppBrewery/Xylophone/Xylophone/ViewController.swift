//
//  ViewController.swift
//  Xylophone
//
//  Created by Angela Yu on 28/06/2019.
//  Copyright © 2019 The App Brewery. All rights reserved. Template ONLY
//
import UIKit
import AVFoundation
/*
    This ViewController.swift file powers a simple xylophone app.
    When a user taps a button labeled with a musical note, the app
    plays the corresponding .wav sound file. It uses asynchronous logic
    to briefly dim the button for visual feedback and then plays the
    sound using AVAudioPlayer
*/
class ViewController: UIViewController {
    
    // Declare an optional AVAudioPlayer instance to handle sound playback
    var player: AVAudioPlayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // No setup needed on view load for this app
    }

    // IBAction triggered when a xylophone key is pressed
    @IBAction func keyPressed(_ sender: Any) {
        // Use Swift's concurrency model to run UI updates and sound playback on the main thread
        Task { @MainActor in
            // Safely cast the sender to UIButton
            let rtButton: UIButton = sender as! UIButton
            // Get the button's title, which corresponds to the sound file name
            let rtBtnTextData: String = rtButton.currentTitle!
            
            // Dim the button to give visual feedback
            rtButton.alpha = 0.5
            print("Start")
            
            // Play the sound asynchronously with a short delay
            await asyncSound(soundName: rtBtnTextData)
            print("End")
            
            // Restore button opacity after sound plays
            rtButton.alpha = 1
        }
    }
    
    // Asynchronous function to delay and then play the sound
    func asyncSound(soundName: String) async {
        do {
            // Introduce a 0.2 second delay before playing the sound
            try await Task.sleep(nanoseconds: 200000000)
        } catch let error {
            // Log an errors that occr during the delay
            print(error.localizedDescription)
        }
        // Call the sound playback function
        playSound(soundType: soundName)
    }

    // Function to play the sound file using AVAudioPlayer
    func playSound(soundType: String)
    {
        // Gard against empty sound names
        if (soundType == "") {
            return
        }
        
        // Locate the .wav file in the app bundle
        guard let url = Bundle.main.url(forResource: soundType, withExtension: "wav") else { return }
        
        do {
            // Set up the audio session for playback
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
            
            // Initialize the audio player with the sound file
            player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.wav.rawValue)
            
            // Ensure the player is valid before playing
            guard let player = player else { return }
            
            // Play the sound
            player.play()
            
        } catch let error {
            // Log any erros during audio setup or playback
            print(error.localizedDescription)
        }
    }
}
