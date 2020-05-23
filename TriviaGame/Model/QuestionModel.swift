//
//  QuestionModel.swift
//  TriviaGame
//
//  Created by Toni De Gea on 04/05/2020.
//  Copyright © 2020 Toni De Gea. All rights reserved.
//

import Foundation


// MARK: - Welcome
struct TriviaAPI: Codable {
    let responseCode: Int?
    let results: [Result]

    enum CodingKeys: String, CodingKey {
        case responseCode
        case results
    }
}

// MARK: - Result
struct Result: Codable {
    let category: String
    let type: String
    let difficulty: String
    let question, correctAnswer: Data
    let incorrectAnswers: [Data]

    enum CodingKeys: String, CodingKey {
        case category, type, difficulty
        case question
        case correctAnswer = "correct_answer"
        case incorrectAnswers = "incorrect_answers"
    }
}
