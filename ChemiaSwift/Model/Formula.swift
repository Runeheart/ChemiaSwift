//
//  Formula.swift
//  ChemiaSwift
//
//  Created by Jonah Austin on 3/15/17.
//  Copyright © 2017 edu.bsu. All rights reserved.
//

import Foundation

class Formula {
    
    private var centerElement: Element = ElementFactory.create(withSymbol: .H)
    private var attachedElements = [String : Int]()
    private var formulaOrder: [String] = Array(repeating: "", count: FormulaConstants.MostDistinctElementsPossible)
    private var formulaIndex = 0
    
    
    func setCenter(element el: Element) {
        centerElement = el
        let givenSymbol = el.getSymbol()
        formulaOrder[0] = givenSymbol
        if formulaIndex == 0 {
            formulaIndex += 1
        }
    }
    
    func centerAtom() -> Element {
        return centerElement
    }
    
    func addAttached(element: Element) {
        let givenSymbol = element.getSymbol()
        attachedElements[givenSymbol] = 1
        formulaOrder[formulaIndex] = givenSymbol
        formulaIndex += 1
    }
    
    func updateAttached(element: Element, value: Int) {
        attachedElements.updateValue(value, forKey: element.getSymbol())
    }
    
    func simpleForm() -> String {
        var result = centerElement.getSymbol()
        var sub = 0
        for element in formulaOrder.suffix(from: 1) where element != "" {
            if element == result {
                result.append("2")
            } else {
                sub = attachedElements[element] ?? 0
                if sub == 1 {
                    result.append("\(element)")
                } else if sub > 1 {
                    result.append("\(element)\(sub)")
                }
            }
        }
        return result
    }
    
    func calculateValence() -> Int {
        var result = centerElement.numValElectrons()
        let contents = ElementList.contents
        for (_, val) in attachedElements.enumerated() {
            let sym = val.key
            let sub = val.value
            let el = contents[contents.index(where: {$0.getSymbol() == sym})!]
            result += (el.numValElectrons() * sub)
        }
        return result
    }
    
    func numberOfAtoms() -> Int {
        var result = 1
        for val in attachedElements.values {
            result += val
        }
        return result
    }
    
    func valenceBreakdown() -> [(Int,Int)] {
        var result: [(Int,Int)] = [(1, centerElement.numValElectrons())]
        for (_, val) in attachedElements.enumerated() {
            let sym = val.key
            let sub = val.value
            let contents = ElementList.contents
            let el = contents[contents.index(where: {$0.getSymbol() == sym})!]
            result.append((sub, el.numValElectrons()))
        }
        return result
    }
    
    func elementsArray() -> [Element] {
        var results: [Element] = [centerElement]
        for (_, val) in attachedElements.enumerated() {
            let sym = val.key
            let sub = val.value
            let el = ElementFactory.create(withSymbol: Element.ChemSymbol(rawValue: sym)!)
            for _ in 1...sub {
                results.append(el)
            }
        }
        return results
    }
    
}

enum FormulaConstants {
    static let MostDistinctElementsPossible = 3
    static let MaxAtomsAllowed = 7
}


