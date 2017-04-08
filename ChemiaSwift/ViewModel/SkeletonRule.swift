//
//  SkeletonRule.swift
//  ChemiaSwift
//
//  Created by Jonah Austin on 3/22/17.
//  Copyright © 2017 edu.bsu. All rights reserved.
//

import Foundation

class SkeletonRule : LewisRule {
    
    private let currentStructure: LewisStructure
    let currentFormula: Formula
    private var symbols = [ReuseIdentifiers : [String]]()
    private var currentElements: [Element]
    
    init(withStructure struc: LewisStructure) {
        currentStructure = struc
        currentFormula = currentStructure.getFormula()
        currentElements = currentFormula.elementsArray()
    }
    
    func setSymbols() {
        setCenterSymbols()
        setAttachedSymbols()
    }
    
    private func setCenterSymbols() {
        var results: [String] = []
        defer {
            symbols[.center] = results
        }
        
        results.append("")
        let centerElement = currentElements.removeFirst()
        results.append(centerElement.getSymbol())
        
        let otherPossibleCenters = currentElements.filter {$0 != ElementList.hydrogen}
        for i in 0..<otherPossibleCenters.count {
            let sym = otherPossibleCenters[i].getSymbol()
            if !results.contains(sym) {
                results.append(sym)
            }
        }
    }
    
    private func setAttachedSymbols() {
        var results: [String] = []
        defer {
            symbols[.attached] = results
        }
        
        results.append("")
        for i in 0..<currentElements.count {
            let sym = currentElements[i].getSymbol()
            if !results.contains(sym) {
                results.append(sym)
            }
        }
        
    }
    
    func nextDisplayTitle (from title: String, at identifier: ReuseIdentifiers) -> String {
        let choices: [String] = symbols[identifier]!
        let nextTitleIndex = choices.index(of: title)! + 1
        let nextTitle = choices[nextTitleIndex % choices.count]
        return nextTitle
    }
    
    func numAtoms() -> Int {
        return currentFormula.numberOfAtoms()
    }
    
    func centerAtom() -> Element {
        return currentFormula.centerAtom()
    }
    
    func elementAt(index i: Int) -> Element {
        return currentElements[i]
    }
    
    override func description() -> String {
        return "Place each Element in the buttons provided by tapping each until you think it displays the correct symbol. For convenience, simply enter the attached atoms in the order the formula is written.\n\n Also, you'll want to add a single bond between each attached atom and the center atom. \n\n Your guess will be checked upon hitting Submit."
    }
    
    enum ReuseIdentifiers: String {
        case center = "center"
        case attached = "attached"
    }
    
    func subscriptedFormula() -> NSAttributedString {
        let formatter = FormulaFormatter()
        return formatter.subscriptedFormulaFrom(inputString: currentFormula.simpleForm())
    }
    
    
}
