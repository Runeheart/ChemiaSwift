//
//  BondsValidationTests.swift
//  ChemiaSwift
//
//  Created by Jonah Austin on 4/7/17.
//  Copyright © 2017 edu.bsu. All rights reserved.
//

import XCTest

class BondsValidationTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testCO2Complete() {
        let centerAtom: Element = ElementFactory.create(withSymbol: .C)
        let centerElementState: CenterElementState = CenterElementState(of: centerAtom)
        centerElementState.suggestedElementSymbol = "C"
        centerElementState.setNumberOfLonePairs(to: 0)
        
        var attachedElementStates: [AttachedElementState] = []
        for _ in 1...2 {
            let nextAttachedState: AttachedElementState = AttachedElementState(of: ElementFactory.create(withSymbol: .O), withTarget: centerElementState)
            nextAttachedState.suggestedElementSymbol = "O"
            nextAttachedState.bondNumSuggested = 2
            nextAttachedState.setNumberOfBonds(to: 1, ofType: .double)
            nextAttachedState.lonePairNumSuggested = 2
            nextAttachedState.setNumberOfLonePairs(to: 2)
            attachedElementStates.append(nextAttachedState)
        }
        
        let formulaState: FormulaState = FormulaState(center: centerElementState, attached: attachedElementStates)
        formulaState.checkCompletion(forRule: .bonds)
        
        XCTAssertTrue(formulaState.isCompleted())
    }
    
    func testFormaldehydeComplete() {
        let centerAtom: Element = ElementFactory.create(withSymbol: .C)
        let centerElementState: CenterElementState = CenterElementState(of: centerAtom)
        centerElementState.suggestedElementSymbol = "C"
        centerElementState.setNumberOfLonePairs(to: 0)
        
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
        let otherAttachedState: AttachedElementState = AttachedElementState(of: ElementFactory.create(withSymbol: .O), withTarget: centerElementState)
        otherAttachedState.suggestedElementSymbol = "O"
        otherAttachedState.bondNumSuggested = 1
        otherAttachedState.setNumberOfBonds(to: 1, ofType: .double)
        otherAttachedState.lonePairNumSuggested = 2
        otherAttachedState.setNumberOfLonePairs(to: 2)
        attachedElementStates.append(otherAttachedState)
        
        let formulaState: FormulaState = FormulaState(center: centerElementState, attached: attachedElementStates)
        formulaState.checkCompletion(forRule: .bonds)
        
        XCTAssertTrue(formulaState.isCompleted())
    }
    
    func testXeF6Complete() {
        let centerAtom: Element = ElementFactory.create(withSymbol: .Xe)
        let centerElementState: CenterElementState = CenterElementState(of: centerAtom)
        centerElementState.suggestedElementSymbol = "Xe"
        centerElementState.lonePairNumSuggested = 1
        centerElementState.setNumberOfLonePairs(to: 1)
        
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
        formulaState.checkCompletion(forRule: .bonds)
        
        XCTAssertTrue(formulaState.isCompleted())
    }
    
//    func testPerformanceExample() {
//        // This is an example of a performance test case.
//        self.measure {
//            // Put the code you want to measure the time of here.
//        }
//    }
    
}
