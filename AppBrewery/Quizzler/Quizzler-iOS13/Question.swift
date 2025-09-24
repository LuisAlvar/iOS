//
//  Question.swift
//  Quizzler-iOS13
//
//  Created by Luis Alvarez on 9/23/25.
//  Copyright © 2025 The App Brewery. All rights reserved.
//

struct Question {
    let text: String
    let answer: String
    init(q: String, a: String) {
        self.text = q
        self.answer = a
    }
}
