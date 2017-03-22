//
//  BondManagerTests.swift
//  ChemiaSwift
//
//  Created by Jonah Austin on 3/21/17.
//  Copyright © 2017 edu.bsu. All rights reserved.
//

import XCTest
@testable import ChemiaSwift

class BondManagerTests: XCTestCase {
    
    var formula: Formula = Formula()
    var testBondManager: BondManager = BondManager()
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        formula = Formula()
        formula.add(element: ElementList.carbon)
        formula.add(element: ElementList.oxygen)
        testBondManager = BondManager(withFormula: formula)
        
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testAddingSingleBond() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let testSingleBond = Bond.between(ElementList.carbon).and(ElementList.oxygen)
        
        testBondManager.addBond(testSingleBond)
        
        XCTAssertEqual(testBondManager.numBonds, 1)
        XCTAssertEqual(testBondManager.typeOf(bond: testSingleBond), .single)
    }
    
    func testUpgradingSingleBond() {
        
        let testSingleBond = Bond.between(ElementList.carbon).and(ElementList.oxygen)
        
        testBondManager.addBond(testSingleBond)
        testBondManager.addBond(testSingleBond)
        
        XCTAssertEqual(testBondManager.numBonds, 1)
        XCTAssertEqual(testBondManager.typeOf(bond: testSingleBond), .double)
    }
    /*
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    */
    
}
