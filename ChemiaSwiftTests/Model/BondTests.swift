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
    
    var A: Element = Element()
    var B: Element = Element()
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        A = ElementFactory.create(withSymbol: .C)
        B = ElementFactory.create(withSymbol: .O)
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testBondEqualsExact() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        let AtoB = Bond.between(A).and(B)
        let AtoB2 = Bond.between(A).and(B)
        
        XCTAssertEqual(AtoB, AtoB2)
    }
    
    func testBondEqualsEquivalent() {
        
        let AtoB = Bond.between(A).and(B)
        let BtoA = Bond.between(B).and(A)
        
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
