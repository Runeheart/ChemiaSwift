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
    
    init(withManager manager: BondManager) {
        currentStructure = manager
    }
    
    convenience init() {
        self.init(withManager: BondManager())
    }
    
    func generateElementButtons() -> [ElementButton] {
        var results: [ElementButton] = []
        let numButtonsToGenerate = currentStructure.designatedFormula.numberOfAtoms()
//        let formulaElements = currentStructure.designatedFormula.elementsArray()
        results.append(ElementButton())
        for _ in 2...numButtonsToGenerate {
            results.append(ElementButton(type: .custom))
        }
        
        return results
    }
    
    
}
