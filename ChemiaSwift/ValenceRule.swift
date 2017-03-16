//
//  ValenceRule.swift
//  ChemiaSwift
//
//  Created by Jonah Austin on 3/15/17.
//  Copyright © 2017 edu.bsu. All rights reserved.
//

import Foundation

class ValenceRule: LewisRule {
    
    var formula: Formula = Formula()
    var correctValence: Int = 0
    
    init(withFormula form:Formula) {
        self.formula = form
    }
    
    func getPossibleAnswers() -> [Answer] {
        var possibleValues: [Int] = Array(repeating: 0, count: 5)
        correctValence = formula.calculateValence()
        possibleValues[0] = correctValence // correct answer
        for index in 1...4 {
            possibleValues[index] = generateWrongValue()
        }
        
        let assembledAnswers: [Answer] = assemble(possibleValues)
        return assembledAnswers
    }
    
    private func generateWrongValue() -> Int {
        return 1
    }
    
    private func assemble(_ values: [Int]) -> [Answer] {
        var result: [Answer] = [Answer]()
        for num in values {
            if num == correctValence {
                result.append(Answer(choice: num, parity: .correct))
            } else {
                result.append(Answer(choice: num, parity: .incorrect))
            }
        }
        return result
    }
    
    func description() -> String {
        return ""
    }
    
}
