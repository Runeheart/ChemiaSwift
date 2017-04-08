//
//  FormulaBuilder.swift
//  ChemiaSwift
//
//  Created by Jonah Austin on 4/8/17.
//  Copyright © 2017 edu.bsu. All rights reserved.
//

import Foundation

class FormulaBuilder {
    
    private var orderSize = FormulaConstants.MostDistinctElementsPossible
    var currentSelection = [String : Int]()
    var formulaOrder: [String] = Array(repeating: "", count: FormulaConstants.MostDistinctElementsPossible)
    var formulaIndex = 0
    var chosenAdditionalSymbol = ""
    var resetStepperValue = false
    
    
    init() {}
    
    func changeSelection(element: Element, from: SelectionCase) -> Int {
        switch from {
        case .center:
            formulaOrder[0] = element.getSymbol()
            formulaOrder.replaceSubrange(1...orderSize-1, with: Array(repeating: "", count: orderSize-1))
            currentSelection.removeAll()
            currentSelection[element.getSymbol()] = 1
            formulaIndex = 1
        case .attached:
            chosenAdditionalSymbol = element.getSymbol()
            currentSelection[chosenAdditionalSymbol] = 1
            if formulaOrder.contains(chosenAdditionalSymbol) { }
            else {
                if formulaIndex < formulaOrder.capacity {
                    formulaOrder[formulaIndex] = chosenAdditionalSymbol
                    formulaIndex += 1
                } else {
                    // lol this error is hilarious
                    //print("formulaIndex out of bounds?")
                }
                
            }
        }
        return formulaIndex
    }
    
    func assembleFormula() -> String {
        var formula = ""
        for element in formulaOrder where element != "" {
            let sub = currentSelection[element] ?? 0
            if sub == 1 {
                formula.append("\(element)")
            } else if sub > 1 {
                formula.append("\(element)\(sub)")
            }
        }
//        print(formula + " : formula index is \(formulaIndex+1)")
        return formula
    }
    
    func resolveStepperValue(val: Int) {
        if resetStepperValue {
            resetStepperValue = false
        }
        switch val {
        case 0:
            formulaOrder.remove(at: formulaOrder.index(of: chosenAdditionalSymbol)!)
            currentSelection.removeValue(forKey: chosenAdditionalSymbol)
            formulaIndex -= 1
        case 1:
            if currentSelection.index(forKey: chosenAdditionalSymbol) == nil {
                currentSelection[chosenAdditionalSymbol] = 1
                formulaOrder[formulaIndex] = chosenAdditionalSymbol
                formulaIndex += 1
                resetStepperValue = true
            } else {
                currentSelection.updateValue(val, forKey: chosenAdditionalSymbol)
            }
        case 2...(FormulaConstants.MaxAtomsAllowed-1):
            currentSelection.updateValue(val, forKey: chosenAdditionalSymbol)
        default: break
        }
        
    }
    
    func resetSelection() {
        formulaOrder = Array(repeating: "", count: orderSize)
        currentSelection.removeAll()
        formulaIndex = 0
        //        print(formulaOrder.debugDescription)
        //        print(currentSelection.debugDescription)
    }
    
    
}

enum SelectionCase {
    case center, attached
}
