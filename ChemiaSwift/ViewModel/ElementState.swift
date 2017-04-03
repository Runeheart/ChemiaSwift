//
//  ElementState.swift
//  ChemiaSwift
//
//  Created by Jonah Austin on 4/1/17.
//  Copyright © 2017 edu.bsu. All rights reserved.
//

import Foundation

class ElementState {
    
    fileprivate var element: Element = ElementFactory.create(withSymbol: .H)
    
    private var bondNumSuggested: Int = 0
    fileprivate var lonePairNumSuggested: Int = 0
    private lazy var octetElectronsSuggested: Int = {
        return self.bondNumSuggested*2 + self.lonePairNumSuggested*2
    }()
    
    init(of el: Element) {
        element = el
    }
    
    init() {}
    
    func setNumberOfBonds(to num: Int) {
        bondNumSuggested = num
    }
    
    func hasFullOctet() -> Bool {
        return octetElectronsSuggested == element.numOctetElectrons()
    }
    
    func octet() -> Int {
        return element.numOctetElectrons()
    }
    
    func valence() -> Int {
        return element.numValElectrons()
    }
    
    func suggestedValence() -> Int {
        return 0
    }
    
}

class CenterElementState: ElementState {
    
    var bonds: [Bond] = []
    private var bondTypes = [Bond:BondType]()
    
    fileprivate func add(_ bond: Bond, ofType type: BondType) {
        bonds.append(bond)
        bondTypes[bond] = type
        setNumberOfBonds(to: bonds.count)
    }
    
    func typeOf(bond: Bond) -> BondType {
        if let type = bondTypes[bond] {
            return type
        }
        return .null
    }
    
    override func suggestedValence() -> Int {
        var sum = 0
        for (_, val) in bondTypes.enumerated() {
            let cardinality = val.value.rawValue
            sum += (2*cardinality)
        }
        return sum
    }
    
}

class AttachedElementState: ElementState {
    
    private var centerTarget: CenterElementState
    var bond: Bond? = nil
    
    init(of el: Element, withTarget target: CenterElementState) {
        centerTarget = target
        super.init(of: el)
    }
    
    override func setNumberOfBonds(to num: Int) {
        super.setNumberOfBonds(to: num)
    
        bond = Bond.between(element).and(centerTarget.element)
        let bondType = BondType(rawValue: num)
        centerTarget.add(bond!, ofType: bondType!)
    }
    
    override func suggestedValence() -> Int {
        return (lonePairNumSuggested * 2)
    }
    
}
