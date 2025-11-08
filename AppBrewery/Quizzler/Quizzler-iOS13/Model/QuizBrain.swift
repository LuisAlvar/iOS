//
//  QuizBrain.swift
//  Quizzler-iOS13
//
//  Created by Luis Alvarez on 10/5/25.
//  Copyright © 2025 The App Brewery. All rights reserved.
//

import Foundation

/// Represents the functionality of an automated quiz with a set of Questions 
struct QuizBrain
{
    let quiz = [
        Question(q: "A slug's blood is green.", a: "True"),
        Question(q: "Approximately one quarter of human bones are in the feet.", a: "True"),
        Question(q: "The total surface area of two human lungs is approximately 70 square metres.", a: "True"),
        Question(q: "In West Virginia, USA, if you accidentally hit an animal with your car, you are free to take it home to eat.", a: "True"),
        Question(q: "In London, UK, if you happen to die in the House of Parliament, you are technically entitled to a state funeral, because the building is considered too sacred a place.", a: "False"),
        Question(q: "It is illegal to pee in the Ocean in Portugal.", a: "True"),
        Question(q: "You can lead a cow down stairs but not up stairs.", a: "False"),
        Question(q: "Google was originally called 'Backrub'.", a: "True"),
        Question(q: "Buzz Aldrin's mother's maiden name was 'Moon'.", a: "True"),
        Question(q: "The loudest sound produced by any animal is 188 decibels. That animal is the African Elephant.", a: "False"),
        Question(q: "No piece of square dry paper can be folded in half more than 7 times.", a: "False"),
        Question(q: "Chocolate affects a dog's heart and nervous system; a few ounces are enough to kill a small dog.", a: "True"),
        
        Question(q: "Which is the largest organ in the human body?", a:"Skin", t: "Multiple", o: ["Heart", "Skin", "Large Intestine"]),
        Question(q: "Which planet in our solar system has the longest day?", a: "Jupiter", t: "Multiple", o: ["Mercury", "Venus", "Earth", "Jupiter"]),
        Question(q: "Which is the only mammal that can fly?", a: "Bat", t: "Multiple", o: ["Bat", "Whale", "Eagle", "Penguin"]),
        Question(q: "Five dollars is worth how many nickels?", a: "100", t: "Multiple", o: ["25", "50", "100"]),
        Question(q: "What do the letters in the GMT time zone stand for?", a:"Greenwich Mean Time", t: "Multiple", o: ["Global Meridian Time", "Greenwich Mean Time", "General Median Time"]),
        Question(q: "What is the French word for 'hat'?", a:"Chapeau", t:"Multiple", o: ["Chapeau", "Écharpe", "Bonnet"]),
        Question(q: "In past times, what would a gentleman keep in his fob pocket?", a: "Watch", t:"Multiple", o: ["Notebook", "Handkerchief", "Watch"]),
        Question(q: "Which is the smallest prime number?", a: "2", t:"Multiple", o: ["2", "3", "5"]),
        Question(q: "How would one say goodbye in Spanish?", a: "Adiós", t:"Multiple", o:["Au Revoir", "Adiós", "Salir"]),
        Question(q: "Which of these colours is NOT featured in the logo for Google?", a:"Orange", t:"Multiple", o: ["Green", "Orange", "Blue"]),
        Question(q: "What alcoholic drink is made from molasses?", a:"Rum", t:"Multiple", o: ["Rum", "Whisky", "Gin"]),
        Question(q: "What type of animal was Harambe?", a: "Gorilla", t:"Multiple", o: ["Panda", "Gorilla", "Crocodile"]),
        Question(q: "Where is Tasmania located?", a:"Australia", t:"Multiple", o: ["Indonesia", "Australia", "Scotland"])
    ]
    
    var questionNumber: Int
    var scoreRatio: Float
    var correctAnswers: Int
    
    /// Utilize array for tracking question we have already answered; 1 for answered, otherwise 0.
    var tracker: [Int]
    /// Utilize integer for tracking question we have already answered; the 1s
    var numberOfQuestionsAnswered: Int
    
    init() {
        self.questionNumber = Int.random(in: 0..<quiz.count)
        self.correctAnswers = 0
        self.scoreRatio =  100.0/Float(quiz.count)
        self.tracker = Array(repeating: 0, count: quiz.count)
        self.numberOfQuestionsAnswered = 0
    }
    
    func getQuestionType() -> String
    {
        return quiz[questionNumber].type
    }
    
    func getQuestionText() -> String
    {
        return quiz[questionNumber].text
    }
    
    func getProgress() -> Float {
        return Float(self.numberOfQuestionsAnswered+1) / Float(quiz.count)
    }
    
    func getQuestionOptions() -> [String]
    {
        return quiz[questionNumber].options
    }
    
    func getScore() -> Float {
        return round(Float(correctAnswers) * scoreRatio * 10)/10;
    }
    
    func getTotalQuestions() -> Int {
        return quiz.count
    }
    
    func getQuestionAnswered() -> Int {
        return numberOfQuestionsAnswered
    }
    
    func checkAnswer(_ userAnswer: String) -> Bool
    {
        if userAnswer == quiz[questionNumber].answer {
            return true
        }
        return false
    }
    
    mutating func updateScore(_ userAnsweredCorrectly: Bool)
    {
        if userAnsweredCorrectly {
            self.correctAnswers += 1
        }
    }
    
    mutating func nextQuestion() {
        if (numberOfQuestionsAnswered == quiz.count-1)
        {
            self.tracker = Array(repeating: 0, count: quiz.count)
            self.numberOfQuestionsAnswered = 0
            self.correctAnswers = 0
        }
        // if we have not answered this particular question and number of questions
        // we already answered is not number of question required, then we want
        // this questionNumber - TRUE; We negate ~(True) to stop the looping.
        repeat {
            self.questionNumber = Int.random(in: 0..<quiz.count)
        } while !(tracker[questionNumber] != 1 && numberOfQuestionsAnswered != quiz.count)
    
    }
    
    mutating func markQuestionAsAnswered() {
        self.tracker[questionNumber] = 1
        self.numberOfQuestionsAnswered += 1
    }
    
}
