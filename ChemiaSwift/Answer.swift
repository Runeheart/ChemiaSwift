//
//  Answer.swift
//  ChemiaSwift
//
//  Created by Jonah Austin on 3/15/17.
//  Copyright © 2017 edu.bsu. All rights reserved.
//

import Foundation

struct Answer {
    var content: Any
    var isCorrect: Bool
    
    init(choice: Any, parity: Bool) {
        self.content = choice
        self.isCorrect = parity
    }
}

enum AnswerParity {
    static let Correct = true
    static let Incorrect = false
}
