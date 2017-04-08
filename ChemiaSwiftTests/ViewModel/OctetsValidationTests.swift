//
//  OctetsValidationTests.swift
//  ChemiaSwift
//
//  Created by Jonah Austin on 4/5/17.
//  Copyright © 2017 edu.bsu. All rights reserved.
//

import XCTest
@testable import ChemiaSwift

class OctetsValidationTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testCCl4Complete() {
        let centerAtom: Element = ElementFactory.create(withSymbol: .C)
        let centerElementState: CenterElementState = CenterElementState(of: centerAtom)
        centerElementState.suggestedElementSymbol = "C"
        
        var attachedElementStates: [AttachedElementState] = []
        for _ in 1...4 {
            let nextAttachedState: AttachedElementState = AttachedElementState(of: ElementFactory.create(withSymbol: .Cl), withTarget: centerElementState)
            nextAttachedState.suggestedElementSymbol = "Cl"
            nextAttachedState.bondNumSuggested = 1
            nextAttachedState.setNumberOfBonds(to: 1, ofType: .single)
            nextAttachedState.lonePairNumSuggested = 3
            nextAttachedState.setNumberOfLonePairs(to: 3)
            attachedElementStates.append(nextAttachedState)
        }
        
        let formulaState: FormulaState = FormulaState(center: centerElementState, attached: attachedElementStates)
        formulaState.checkCompletion(forRule: .octets)
        
        XCTAssertTrue(formulaState.isCompleted())
    }
    
    func testCO2RuleComplete() {
        let centerAtom: Element = ElementFactory.create(withSymbol: .C)
        let centerElementState: CenterElementState = CenterElementState(of: centerAtom)
        centerElementState.suggestedElementSymbol = "C"
        centerElementState.setNumberOfLonePairs(to: 2)
        
        var attachedElementStates: [AttachedElementState] = []
        for _ in 1...2 {
            let nextAttachedState: AttachedElementState = AttachedElementState(of: ElementFactory.create(withSymbol: .O), withTarget: centerElementState)
            nextAttachedState.suggestedElementSymbol = "O"
            nextAttachedState.bondNumSuggested = 1
            nextAttachedState.setNumberOfBonds(to: 1, ofType: .single)
            nextAttachedState.lonePairNumSuggested = 3
            nextAttachedState.setNumberOfLonePairs(to: 3)
            attachedElementStates.append(nextAttachedState)
        }
        
        let formulaState: FormulaState = FormulaState(center: centerElementState, attached: attachedElementStates)
        formulaState.checkCompletion(forRule: .octets)
        
        XCTAssertFalse(formulaState.isCompleted())
        XCTAssertTrue(formulaState.ruleCompleted())
    }
    
//    func testPerformanceExample() {
//        // This is an example of a performance test case.
//        self.measure {
//            // Put the code you want to measure the time of here.
//        }
//    }
    
}
