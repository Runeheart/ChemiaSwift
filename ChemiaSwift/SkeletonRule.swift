//
//  SkeletonRule.swift
//  ChemiaSwift
//
//  Created by Jonah Austin on 3/22/17.
//  Copyright © 2017 edu.bsu. All rights reserved.
//

import Foundation

class SkeletonRule {
    
    let currentStructure: BondManager
    var symbols: [String] = []
    
    init(withManager manager: BondManager) {
        currentStructure = manager
    }
    
    convenience init() {
        self.init(withManager: BondManager())
    }
    
    func getPossibleAnswers() -> [String] {
        let results: [String] = []
        defer {
            symbols = results
        }
        
        let numButtonsToGenerate = currentStructure.designatedFormula.numberOfAtoms()
        var formulaElements = currentStructure.designatedFormula.elementsArray()
        
        let centerElement = formulaElements.removeFirst()
        
        for _ in 2...numButtonsToGenerate {

        }
        
        return results
    }
    
    func nextDisplayTitle (from sym: String) -> String {
        
        
        
        return ""
    }
    
    
}
