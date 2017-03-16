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
    
    init(withFormula form:Formula) {
        self.formula = form
    }
    
    func getPossibleAnswers() -> [Answer] {
        let possibleValues: [Int] = [10]
        
        let assembledAnswers: [Answer] = assemble(possibleValues)
        return assembledAnswers
    }
    
    private func assemble(_ values: [Int]) -> [Answer] {
        return [Answer(choice: 10, parity: AnswerParity.Correct)]
    }
    
    func description() -> String {
        return ""
    }
    
}
