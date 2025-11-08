//
//  ViewController.swift
//  Quizzler-iOS13
//
//  Created by Angela Yu on 12/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    
    @IBOutlet weak var trueButton: UIButton!
    @IBOutlet weak var falseButton: UIButton!
    @IBOutlet weak var optionCButton: UIButton!
    
    var quizBrain = QuizBrain()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        updateUI()
    }
    
    
    @IBAction func answerButtonPressed(_ sender: UIButton) {
        let userSelectedAnswer = sender.currentTitle! //True or False
        let userGotItRight = quizBrain.checkAnswer(userSelectedAnswer);
        if userGotItRight {
            sender.backgroundColor = UIColor.green
        }
        else {
            sender.backgroundColor = UIColor.red
        }
        quizBrain.markQuestionAsAnswered()
        quizBrain.updateScore(userGotItRight)
        quizBrain.nextQuestion()
        
        Timer.scheduledTimer(timeInterval: 0.2, target: self, selector: #selector(updateUI), userInfo: nil, repeats: false)
    }
    
    @objc func updateUI()
    {
        questionLabel.text = quizBrain.getQuestionText()
        progressBar.progress = quizBrain.getProgress()
        scoreLabel.text = "\(quizBrain.getQuestionAnswered())/\(quizBrain.getTotalQuestions()) Score: \(quizBrain.getScore())"
        
        if (quizBrain.getQuestionType()=="Bool")
        {
            trueButton.isHidden = false
            falseButton.isHidden = false
            optionCButton.isHidden = true
        }
        else{
            trueButton.isHidden = false
            falseButton.isHidden = false
            optionCButton.isHidden = false
        }
        
        if (quizBrain.getQuestionType() == "Bool")
        {
            trueButton.setTitle("True", for: .normal)
            falseButton.setTitle("False", for: .normal)
        }
        else {
            let options: [String] = quizBrain.getQuestionOptions()
            trueButton.setTitle(options[0], for: .normal)
            falseButton.setTitle(options[1], for: .normal)
            optionCButton.setTitle(options[2], for: .normal)
        }
        
        trueButton.backgroundColor = UIColor.clear
        falseButton.backgroundColor = UIColor.clear
        optionCButton.backgroundColor = UIColor.clear
    }
    
    
}
