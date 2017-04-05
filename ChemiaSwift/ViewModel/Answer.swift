//
//  Answer.swift
//  ChemiaSwift
//
//  Created by Jonah Austin on 3/15/17.
//  Copyright © 2017 edu.bsu. All rights reserved.
//

import Foundation

struct Answer {
    var content: Int
    var isCorrect: Bool
    
    init(choice: Int, parity: AnswerParity) {
        content = choice
        isCorrect = parity == .correct ? true : false
    }
    
    init() {
        self.content = -1
        self.isCorrect = false
    }
}

enum AnswerParity {
    case correct, incorrect
}
