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
    private var bonds = [Bond : BondType]()
    
    var numBonds: Int = 0
    
    init(withFormula form: Formula) {
        designatedFormula = form
    }
    
    convenience init() {
        self.init(withFormula: Formula())
    }
    
    func addBond(_ bond: Bond) {
        
        if bondAlreadyExists(bond) {
            upgradeBondType(of: bond)
        } else {
            bonds[bond] = .single
            numBonds += 1
        }
        
    }
    
    private func bondAlreadyExists(_ bond: Bond) -> Bool {
        return bonds.keys.contains(bond)
    }
    
    private func upgradeBondType(of bond: Bond) {
        switch bonds[bond]! {
        case .single:
            bonds[bond] = .double
        case .double:
            bonds[bond] = .triple
        default:
            bonds[bond] = .null
        }
    }
    
    func typeOf(bond: Bond) -> BondType {
        if let type = bonds[bond] {
            return type
        }
        return .null
    }
    
}

enum BondType {
    case single, double, triple, null
}
