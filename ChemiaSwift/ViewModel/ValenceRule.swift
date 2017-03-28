//
//  ValenceRule.swift
//  ChemiaSwift
//
//  Created by Jonah Austin on 3/15/17.
//  Copyright © 2017 edu.bsu. All rights reserved.
//

import Foundation

class ValenceRule : LewisRule {
    
    var formula: Formula = Formula()
    var correctValence: Int = 0
    
    required override init() {}
    
    init(withFormula form:Formula) {
        self.formula = form
        self.correctValence = formula.calculateValence()
    }
    
    func getPossibleAnswers() -> [Answer] {
        var possibleValues: [Int] = Array(repeating: 0, count: 5)
        possibleValues[0] = correctValence // correct answer
        var wrongValueAttempt = 0
        for index in 1...4 {
            repeat {
                wrongValueAttempt = generateWrongValue()
            } while(possibleValues.contains(wrongValueAttempt))
            possibleValues[index] = wrongValueAttempt
        }
        let assembledAnswers: [Answer] = assemble(possibleValues)
        return assembledAnswers
    }
    
    private func generateWrongValue() -> Int {
        var generated = 0
        repeat {
            if unlikely() {
                generated = generateRandomIncorrect()
            } else {
                generated = generateSmartIncorrect()
            }
        } while(generated == correctValence)
        return generated
    }
    
    private func unlikely() -> Bool {
        let successChance = Double(arc4random_uniform(UInt32(50))+1)/Double(arc4random_uniform(UInt32(100))+1)
        return successChance >= 1.0
    }
    
    private func generateRandomIncorrect() -> Int {
        var attempt = 0
        if fiftyFifty() {
            attempt = sumOfAtoms()
        } else {
            attempt = generateValidNumInRange()
        }
        return attempt
    }
    
    private func fiftyFifty() -> Bool {
        return Int(arc4random_uniform(UInt32(2)+1)) == 1
    }
    
    private func sumOfAtoms() -> Int {
        return formula.numberOfAtoms()
    }
    
    private func generateValidNumInRange() -> Int {
        var num = 0
        repeat {
            num = Int(2*(arc4random_uniform(UInt32(25))+1))
        } while(num == correctValence)
        return num
    }
    
    private func generateSmartIncorrect() -> Int {
        var attempts: [Int] = []
        var attempt = 0
        let valenceCoefficients: [(Int,Int)] = formula.valenceBreakdown()
        for (coeff, valence) in valenceCoefficients {
            attempt = correctValence
            let randomCoeff = Int(arc4random_uniform(UInt32(coeff)+1))
            if fiftyFifty() {
                attempt += (randomCoeff * valence)
            } else {
                attempt -= (randomCoeff * valence)
            }
            attempts.append(attempt)
        }
        let chosenAttemptIndex = Int(arc4random_uniform(UInt32(attempts.count)))
        return attempts[chosenAttemptIndex]
    }
    
    private func assemble(_ values: [Int]) -> [Answer] {
        var result: [Answer] = [Answer]()
        result.append(Answer(choice: values.first!, parity: .correct))
        for num in values.dropFirst() {
            result.append(Answer(choice: num, parity: .incorrect))
        }
        return result
    }
    
    override func description() -> String {
        return "Remember: the group number of an atom determines its number of valence electrons, and you want the sum of all the atoms in your formula."
    }
    
    func subscriptedStringFrom(_ formula: Formula) -> NSAttributedString {
        let formatter = FormulaFormatter()
        return formatter.subscriptedFormulaFrom(inputString: formula.simpleForm())
    }

    
}
