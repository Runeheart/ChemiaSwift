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
    
    var suggestedElementSymbol: String = ""
    var bondNumSuggested: Int = 0
    var lonePairNumSuggested: Int = 0
    
    private var bondNum: Int = 0
    fileprivate var lonePairNum: Int = 0
    private lazy var octetElectrons: Int = {
        return self.bondNum*2 + self.lonePairNum*2
    }()
    
    init(of el: Element) {
        element = el
    }
    
    init() {}
    
    func setNumberOfBonds(to num: Int) {
        bondNum = num
    }
    
    func hasFullOctet() -> Bool {
        return octetElectrons == element.numOctetElectrons()
    }
    
    func verifyTitle() -> Bool {
        return suggestedElementSymbol == element.getSymbol()
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
    private var bondTypes: [BondType] = []
    
    fileprivate func add(_ bond: Bond, ofType type: BondType) {
        bonds.append(bond)
        bondTypes.append(type)
        setNumberOfBonds(to: bonds.count)
    }
    
    func typeOf(bond: Bond) -> BondType {
        if let index = bonds.index(where: {$0 == bond}) {
            return bondTypes[index]
        }
        return .null
    }
    
    override func suggestedValence() -> Int {
        var sum = 0
        for i in 0..<bonds.count {
            let cardinality = bondTypes[i].rawValue
            sum += (2*cardinality)
        }
        return sum
    }
    
    func clearBonds() {
        bonds.removeAll()
        bondTypes.removeAll()
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
        return (lonePairNum * 2)
    }
    
    func verifySingleBondPlaced() -> Bool {
        return bondNumSuggested == 1
    }
    
    func destinationSymbol() -> String {
        return centerTarget.element.getSymbol()
    }
    
}
