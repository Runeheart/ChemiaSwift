//
//  BondTests.swift
//  ChemiaSwift
//
//  Created by Jonah Austin on 3/22/17.
//  Copyright © 2017 edu.bsu. All rights reserved.
//

import XCTest
@testable import ChemiaSwift

class BondTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testBondEqualsExact() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let AtoB = Bond.between(ElementList.carbon).and(ElementList.oxygen)
        let AtoB2 = Bond.between(ElementList.carbon).and(ElementList.oxygen)
        
        XCTAssertEqual(AtoB, AtoB2)
    }
    
    func testBondEqualsEquivalent() {
        
        let AtoB = Bond.between(ElementList.carbon).and(ElementList.oxygen)
        let BtoA = Bond.between(ElementList.oxygen).and(ElementList.carbon)
        
        XCTAssertEqual(AtoB, BtoA)
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
