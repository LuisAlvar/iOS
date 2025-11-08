//
//  Question.swift
//  Quizzler
//
//  Created by Luis Alvarez on 9/23/25.
//  Copyright © 2025 The App Brewery. All rights reserved.
//

/// Represents what a question is essentially
struct Question {
    /// Stores the actual question in text
    let text: String
    
    /// Stores the answer to the question
    let answer: String
    
    /// Stores the kind of a question; possibilities (Bool or Multiple)
    let type: String
    
    /// Stores in the case of the question being Multiple; store all multiple choice
    let options: [String]
    
    /// Default Constructor
    /// - Parameters:
    ///     - q: Pass the text of what the question is
    ///     - a: Pass the answer to the question
    ///     - t: Pass the kind of question this will be. Default is Bool
    ///     - o: Pass the multipe choices if kind of question is Mutiple
    init(q: String, a: String, t: String="Bool", o: [String]=[""]) {
        self.text = q
        self.answer = a
        self.type = t
        self.options = o
    }
}
