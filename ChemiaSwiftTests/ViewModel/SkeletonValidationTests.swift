//
//  SkeletonValidationTests.swift
//  ChemiaSwift
//
//  Created by Jonah Austin on 4/2/17.
//  Copyright © 2017 edu.bsu. All rights reserved.
//

import XCTest
@testable import ChemiaSwift

class SkeletonValidationTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testMethaneComplete() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let centerAtom: Element = ElementFactory.create(withSymbol: .C)
        let centerElementState: CenterElementState = CenterElementState(of: centerAtom)
        centerElementState.suggestedElementSymbol = "C"
        var attachedElementStates: [AttachedElementState] = []
        for _ in 1...4 {
            let nextAttachedState: AttachedElementState = AttachedElementState(of: ElementFactory.create(withSymbol: .H), withTarget: centerElementState)
            nextAttachedState.setNumberOfBonds(to: 1)
            nextAttachedState.suggestedElementSymbol = "H"
            nextAttachedState.bondNumSuggested = 1
            attachedElementStates.append(nextAttachedState)
        }
        
        let formulaState: FormulaState = FormulaState(center: centerElementState, attached: attachedElementStates)
        formulaState.checkCompletion(forRule: .skeleton)
        
        XCTAssertTrue(formulaState.isCompleted())
        
    }
    
//    func testPerformanceExample() {
//        // This is an example of a performance test case.
//        self.measure {
//            // Put the code you want to measure the time of here.
//        }
//    }
    
}
