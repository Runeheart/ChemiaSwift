//
//  LewisStructure.swift
//  ChemiaSwift
//
//  Created by Jonah Austin on 3/18/17.
//  Copyright © 2017 edu.bsu. All rights reserved.
//

import Foundation

class LewisStructure {
    
    private var chemFormula: Formula
    
    init() {
        self.chemFormula = Formula()
    }
    
    init(withFormula form: Formula) {
        self.chemFormula = form
    }
    
}
