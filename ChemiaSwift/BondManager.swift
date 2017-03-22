//
//  BondManager.swift
//  ChemiaSwift
//
//  Created by Jonah Austin on 3/21/17.
//  Copyright © 2017 edu.bsu. All rights reserved.
//

import Foundation

class BondManager {
    
    let designatedFormula: Formula
    private lazy var elementArray: [Element] = {
        return self.designatedFormula.elementsArray()
    }()
    
    var numBonds: Int = 0
    
    init(withFormula form: Formula) {
        designatedFormula = form
    }
    
    convenience init() {
        self.init(withFormula: Formula())
    }
    
    func addBond(_ bond: Bond) {
        
        
        numBonds += 1
    }
    
}
