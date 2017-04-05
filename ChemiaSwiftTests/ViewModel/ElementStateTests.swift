//
//  ElementStateTests.swift
//  ChemiaSwift
//
//  Created by Jonah Austin on 4/1/17.
//  Copyright © 2017 edu.bsu. All rights reserved.
//

import XCTest
@testable import ChemiaSwift

class ElementStateTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testFullOctetMet() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let centerElement: Element = ElementFactory.create(withSymbol: .C)
        let testState: ElementState = ElementState(of: centerElement)
        
        testState.setNumberOfBonds(to: 4)
        XCTAssertTrue(testState.hasFullOctet())
    }
    
    func testBondBetween() {
        let centerElement: Element = ElementFactory.create(withSymbol: .C)
        let testCenter: CenterElementState = CenterElementState(of: centerElement)
        let attachedElement: Element = ElementFactory.create(withSymbol: .H)
        let testAttached: AttachedElementState = AttachedElementState(of: attachedElement, withTarget: testCenter)
        
        testAttached.setNumberOfBonds(to: 1)
        
        let testAttachedBond: Bond = testAttached.bond!
        let testCenterBond: Bond = testCenter.bonds[0]
        
        XCTAssertTrue(testAttachedBond == testCenterBond)
        XCTAssertTrue(testAttachedBond === testCenterBond)
        XCTAssertEqual(testCenter.typeOf(bond: testCenterBond), .single)
        
    }
    
//    func testPerformanceExample() {
//        // This is an example of a performance test case.
//        self.measure {
//            // Put the code you want to measure the time of here.
//        }
//    }
    
}
