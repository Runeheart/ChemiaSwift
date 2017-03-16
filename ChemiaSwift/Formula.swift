//
//  Formula.swift
//  ChemiaSwift
//
//  Created by Jonah Austin on 3/15/17.
//  Copyright © 2017 edu.bsu. All rights reserved.
//

import Foundation

class Formula {
    
    private var elements = [String : Int]()
    private var formulaOrder: [String] = Array(repeating: "", count: FormulaConstants.MostDistinctElementsPossible)
    private var formulaIndex = 0
    
    
    func add(element: Element) {
        let givenSymbol = element.getSymbol()
        elements[givenSymbol] = 1
        formulaOrder[formulaIndex] = givenSymbol
        formulaIndex += 1
    }
    
    func updateElement(element: Element, value: Int) {
        elements.updateValue(value, forKey: element.getSymbol())
    }
    
    func simpleForm() -> String {
        var result = ""
        for element in formulaOrder where element != "" {
            let sub = elements[element] ?? 0
            if sub == 1 {
                result.append("\(element)")
            } else if sub > 1 {
                result.append("\(element)\(sub)")
            }
        }
        return result
    }
    
}

enum FormulaConstants {
    static let MostDistinctElementsPossible = 3
    static let MaxAtomsAllowed = 7
}