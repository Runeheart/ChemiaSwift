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
        let initial = (self.octetSum - self.valenceSum)/2
        if initial < self.attachedAtoms.count {
            return self.attachedAtoms.count
        }
        return initial
    }()
    
    private lazy var expectedNumLonePairs: Int = {
        return (self.valenceSum - (self.expectedNumBonds * 2))/2
    }()
    
    private var currentRule: RuleName = .valence
    private var ruleComplete: Bool = false
    private var isComplete: Bool = false
    
    init(center: CenterElementState, attached: [AttachedElementState]) {
        centerAtom = center
        attachedAtoms = attached
    }
    
    func checkCompletion(forRule rule: RuleName) {
        currentRule = rule
        initializeSums()
        ruleComplete = verifyFor(rule)
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
        case .octets:
            return verifyForOctets()
        case .bonds:
            return true
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
    
    private func verifyForOctets() -> Bool {
        return checkEachAtomFullOctet()
    }
    
    private func checkOverallCompletion() -> Bool {
        let firstCondition = checkEachAtomFullOctet()
        // set/append error(s)
        let secondCondition = checkCorrectValenceElectronTotal()
        let thirdCondition = allBondsPlaced()
        let fourthCondition = allLonePairsPlaced()
        return firstCondition && secondCondition && thirdCondition && fourthCondition
    }
    
    private func checkEachAtomFullOctet() -> Bool {
        var centerCheck: Bool = false
        if centerHasExpandedOctet() {
            centerCheck = true
        } else {
            centerCheck = centerAtom.hasFullOctet()
        }
        var octetCheck = true
        for attached in attachedAtoms {
            octetCheck = attached.hasFullOctet()
            if !octetCheck {
                return false 
            }
        }
        return centerCheck && octetCheck
    }
    
    private func centerHasExpandedOctet() -> Bool {
        return (attachedAtoms.count + 1) > expectedNumBonds
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
        var lonePairsCurrentlyPlaced = centerAtom.lonePairNumSuggested
        for attached in attachedAtoms {
            lonePairsCurrentlyPlaced += attached.lonePairNumSuggested
        }
        return lonePairsCurrentlyPlaced == expectedNumLonePairs
    }
    
    private func allBondsPlaced() -> Bool {
        let bondsCurrentlyPlaced = centerAtom.numBonds()
        var result = bondsCurrentlyPlaced == expectedNumBonds
        if currentRule == .bonds {
            if result == false {
                expectedNumBonds = octetSum - valenceSum
                result = bondsCurrentlyPlaced == expectedNumBonds
            }
        }
        return result
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
