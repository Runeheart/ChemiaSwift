//
//  BondsRule.swift
//  ChemiaSwift
//
//  Created by Jonah Austin on 4/7/17.
//  Copyright © 2017 edu.bsu. All rights reserved.
//

import Foundation

class BondsRule: LewisRule {
    
    private var currentStructure: LewisStructure
    
    init(withStructure struc: LewisStructure) {
        currentStructure = struc
    }
    
    convenience override init() {
        self.init(withStructure: LewisStructure())
    }
    
    override func description() -> String {
        return "Finally, remove lone pairs and add bonds so that the sum of the valence electrons in your structure matches the valence sum of the atoms in your formula. \n\n For example, water would have a total of 8 valence electrons. \n\n Remember, each lone pair and each bond counts as 2 electrons."
    }
    
    func numberOfAtoms() -> Int {
        return currentStructure.numAtoms()
    }
    
    func formula() -> Formula {
        return currentStructure.getFormula()
    }
    
    func getCenterState() -> CenterElementState {
        return currentStructure.getFormulaState().getCenterState()
    }
    
    func getAttachedState(atIndex ind: Int) -> AttachedElementState {
        return currentStructure.getFormulaState().attachedStateAt(index:ind)
    }
    
    func currentState() -> FormulaState {
        return currentStructure.getFormulaState()
    }
    
}
