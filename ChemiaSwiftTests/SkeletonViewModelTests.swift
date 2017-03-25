//
//  SkeletonViewModelTests.swift
//  ChemiaSwift
//
//  Created by Jonah Austin on 3/22/17.
//  Copyright © 2017 edu.bsu. All rights reserved.
//

import XCTest
@testable import ChemiaSwift

class SkeletonViewModelTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testNextDisplayTitle() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        // Preliminary setup
        let testFormula = Formula()
        let centerAtom = ElementFactory.create(withSymbol: .C)
        let attachedAtom = ElementFactory.create(withSymbol: .H)
        testFormula.add(element: centerAtom)
        testFormula.add(element: attachedAtom)
        testFormula.updateElement(element: attachedAtom, value: 4)
        let testBondManager = BondManager(withFormula: testFormula)
        
        
        // Primary setup
        let rule = SkeletonRule(withManager: testBondManager)
        let symbols: [String] = rule.getPossibleAnswers()
        
        // Execution
        
        
    }
    
//    func testPerformanceExample() {
//        // This is an example of a performance test case.
//        self.measure {
//            // Put the code you want to measure the time of here.
//        }
//    }
    
}
