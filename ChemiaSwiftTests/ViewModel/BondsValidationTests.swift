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
    
//    func testPerformanceExample() {
//        // This is an example of a performance test case.
//        self.measure {
//            // Put the code you want to measure the time of here.
//        }
//    }
    
}
