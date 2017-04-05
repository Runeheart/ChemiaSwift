//
//  LewisStructure.swift
//  ChemiaSwift
//
//  Created by Jonah Austin on 3/18/17.
//  Copyright © 2017 edu.bsu. All rights reserved.
//

import Foundation

class LewisStructure {
    
    private let chemFormula: Formula
    private var bondManager: BondManager = BondManager()
    private var formulaState: FormulaState? = nil
    
    init(withFormula form: Formula) {
        self.chemFormula = form
    }
    
    convenience init() {
        self.init(withFormula: Formula())
    }
    
    func getFormula() -> Formula {
        return chemFormula
    }
    
    func getManager() -> BondManager {
        return bondManager
    }
    
    func setBondManagerTo(_ manager: BondManager) {
        bondManager = manager
    }
    
    func getFormulaState() -> FormulaState {
        return formulaState!
    }
    
    func setFormulaStateTo(_ state: FormulaState) {
        formulaState = state
    }
    
    func numAtoms() -> Int {
        return chemFormula.numberOfAtoms()
    }
    
}
