//
//  FormulaState.swift
//  ChemiaSwift
//
//  Created by Jonah Austin on 4/2/17.
//  Copyright © 2017 edu.bsu. All rights reserved.
//

import Foundation

class FormulaState {
    
    private var centerAtom: CenterElementState = CenterElementState()
    private var attachedAtoms: [AttachedElementState] = []
    
    private var octetSum: Int = 0
    private var valenceSum: Int = 0
    private var suggestedValenceSum: Int = 0
    
    private lazy var expectedNumBonds: Int = {
        return (self.octetSum - self.valenceSum)/2
    }()
    
    private lazy var expectedNumLonePairs: Int = {
        return (self.valenceSum - (self.expectedNumBonds * 2))/2
    }()
    
    private var ruleComplete: Bool = false
    private var isComplete: Bool = false
    
    init(center: CenterElementState, attached: [AttachedElementState]) {
        centerAtom = center
        attachedAtoms = attached
    }
    
    func checkCompletion(forRule rule: RuleName) {
        ruleComplete = verifyFor(.skeleton)
        if ruleComplete {
            isComplete = checkOverallCompletion()
        } else {
            isComplete = false
        }
    }
    
    private func verifyFor(_ rule: RuleName) -> Bool {
        switch rule {
        case .valence: fatalError("Should never verify for valence")
        case .skeleton:
            return verifyForSkeleton()
        case .octets: break
        case .bonds: break
        }
        return false
    }
    
    private func verifyForSkeleton() -> Bool {
        let centerSymbolCheck = centerAtom.verifyTitle()
        var attachedSymbolCheck = true
        var attachedBondCheck = true
        for attached in attachedAtoms {
            attachedSymbolCheck = attached.verifyTitle()
            attachedBondCheck = attached.verifySingleBondPlaced()
            if !(attachedSymbolCheck && attachedBondCheck) {
                return false
            }
        }
        
        return centerSymbolCheck && attachedSymbolCheck && attachedBondCheck
    }
    
    private func checkOverallCompletion() -> Bool {
        let firstCondition = checkEachAtomFullOctet()
        // set/append error(s)
        initializeSums()
        let secondCondition = checkCorrectValenceElectronTotal()
        let thirdCondition = allLonePairsPlaced()
        let fourthCondition = allBondsPlaced()
        return firstCondition && secondCondition && thirdCondition && fourthCondition
    }
    
    private func checkEachAtomFullOctet() -> Bool {
        let centerCheck = centerAtom.hasFullOctet()
        var octetCheck = true
        for attached in attachedAtoms {
            octetCheck = attached.hasFullOctet()
            if !octetCheck {
                return false 
            }
        }
        return centerCheck && octetCheck
    }
    
    private func initializeSums() {
        octetSum = centerAtom.octet()
        valenceSum = centerAtom.valence()
        suggestedValenceSum = centerAtom.suggestedValence()
        for attached in attachedAtoms {
            octetSum += attached.octet()
            valenceSum += attached.valence()
            suggestedValenceSum += attached.suggestedValence()
        }
    }
    
    private func checkCorrectValenceElectronTotal() -> Bool {
        return suggestedValenceSum == valenceSum
    }
    
    private func allLonePairsPlaced() -> Bool {
        if expectedNumLonePairs == 0 {
            return true
        }
        return false
    }
    
    private func allBondsPlaced() -> Bool {
        let bondsCurrentlyPlaced = centerAtom.bonds.count
        return bondsCurrentlyPlaced == expectedNumBonds
    }
    
    func ruleCompleted() -> Bool {
        return ruleComplete
    }
    
    func isCompleted() -> Bool {
        return isComplete
    }
    
    func getCenterState() -> CenterElementState {
        return centerAtom
    }
    
    func attachedStateAt(index: Int) -> AttachedElementState {
        return attachedAtoms[index]
    }
    
}
