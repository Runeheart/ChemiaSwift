//
//  OctetsRule.swift
//  ChemiaSwift
//
//  Created by Jonah Austin on 4/4/17.
//  Copyright © 2017 edu.bsu. All rights reserved.
//

import Foundation

class OctetsRule: LewisRule {
    
    private var currentStructure: LewisStructure
    
    init(withStructure struc: LewisStructure) {
        currentStructure = struc
    }
    
    convenience override init() {
        self.init(withStructure: LewisStructure())
    }
    
    override func description() -> String {
        return "Now, you'll want to place any lone pairs on your atoms. \n The goal is for all atoms to have their full octet."
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
