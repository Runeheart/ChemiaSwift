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
    private func octetElectrons() -> Int {
        return bondNum*2 + lonePairNum*2
    }
    
    init(of el: Element) {
        element = el
    }
    
    init() {}
    
    func setNumberOfBonds(to num: Int, ofType type: BondType) {
        bondNum = num * type.rawValue
    }
    
    func setNumberOfLonePairs(to num: Int) {
        lonePairNum = num
    }
    
    func hasFullOctet() -> Bool {
        return self.octetElectrons() == element.numOctetElectrons()
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
    
    fileprivate func suggestedValence() -> Int {
        return 0
    }
    
    
    
}

class CenterElementState: ElementState {
    
    var bonds: [Bond] = []
    private var bondElements = [Bond : Element]()
    
    fileprivate func add(_ bond: Bond, toElement el: Element) {
        bonds.append(bond)
        bondElements[bond] = bond.source
        setNumberOfBonds(to: bonds.count, ofType: bond.type)
    }
    
    func typeOf(bond: Bond) -> BondType {
        if let index = bonds.index(where: {$0 == bond}) {
            return bonds[index].type
        }
        return .null
    }
    
    override func suggestedValence() -> Int {
        var sum = 0
        for bond in bonds {
            let cardinality = bond.type.rawValue
            sum += (2*cardinality)
        }
        return sum
    }
    
    func clearBonds() {
        bonds.removeAll()
        bondElements.removeAll()
    }
    
    func numBonds() -> Int {
        var sum = 0
        for bond in bonds {
            let cardinality = bond.type.rawValue
            sum += cardinality
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
    
    override func setNumberOfBonds(to num: Int, ofType type: BondType) {
        super.setNumberOfBonds(to: num, ofType: type)
        
        if type != .null { 
            bond = Bond.between(element).and(centerTarget.element, withType: type)
            centerTarget.add(bond!, toElement: self.element)
        }
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
