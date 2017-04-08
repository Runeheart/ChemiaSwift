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
    
    func testWaterComplete() {
        let centerAtom: Element = ElementFactory.create(withSymbol: .O)
        let centerElementState: CenterElementState = CenterElementState(of: centerAtom)
        centerElementState.suggestedElementSymbol = "O"
        centerElementState.lonePairNumSuggested = 2
        centerElementState.setNumberOfLonePairs(to: 2)
        
        var attachedElementStates: [AttachedElementState] = []
        for _ in 1...2 {
            let nextAttachedState: AttachedElementState = AttachedElementState(of: ElementFactory.create(withSymbol: .H), withTarget: centerElementState)
            nextAttachedState.suggestedElementSymbol = "H"
            nextAttachedState.bondNumSuggested = 1
            nextAttachedState.setNumberOfBonds(to: 1, ofType: .single)
            nextAttachedState.lonePairNumSuggested = 0
            nextAttachedState.setNumberOfLonePairs(to: 0)
            attachedElementStates.append(nextAttachedState)
        }
        
        let formulaState: FormulaState = FormulaState(center: centerElementState, attached: attachedElementStates)
        formulaState.checkCompletion(forRule: .octets)
        
        XCTAssertTrue(formulaState.isCompleted())
    }
    
    func testSF6Complete() {
        let centerAtom: Element = ElementFactory.create(withSymbol: .S)
        let centerElementState: CenterElementState = CenterElementState(of: centerAtom)
        centerElementState.suggestedElementSymbol = "S"
        centerElementState.lonePairNumSuggested = 0
        centerElementState.setNumberOfLonePairs(to: 0)
        
        var attachedElementStates: [AttachedElementState] = []
        for _ in 1...6 {
            let nextAttachedState: AttachedElementState = AttachedElementState(of: ElementFactory.create(withSymbol: .F), withTarget: centerElementState)
            nextAttachedState.suggestedElementSymbol = "F"
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
    
    func testBF3Complete() {
        let centerAtom: Element = ElementFactory.create(withSymbol: .B)
        let centerElementState: CenterElementState = CenterElementState(of: centerAtom)
        centerElementState.suggestedElementSymbol = "B"
        centerElementState.lonePairNumSuggested = 0
        centerElementState.setNumberOfLonePairs(to: 0)
        
        var attachedElementStates: [AttachedElementState] = []
        for _ in 1...3 {
            let nextAttachedState: AttachedElementState = AttachedElementState(of: ElementFactory.create(withSymbol: .F), withTarget: centerElementState)
            nextAttachedState.suggestedElementSymbol = "F"
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
        centerElementState.lonePairNumSuggested = 2
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
    
    func testXeF6RuleComplete() {
        let centerAtom: Element = ElementFactory.create(withSymbol: .Xe)
        let centerElementState: CenterElementState = CenterElementState(of: centerAtom)
        centerElementState.suggestedElementSymbol = "Xe"
        centerElementState.lonePairNumSuggested = 0
        centerElementState.setNumberOfLonePairs(to: 0)
        
        var attachedElementStates: [AttachedElementState] = []
        for _ in 1...6 {
            let nextAttachedState: AttachedElementState = AttachedElementState(of: ElementFactory.create(withSymbol: .F), withTarget: centerElementState)
            nextAttachedState.suggestedElementSymbol = "F"
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
