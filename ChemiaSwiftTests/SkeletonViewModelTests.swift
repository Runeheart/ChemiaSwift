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
    
    var testBondManager: BondManager = BondManager()
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        let testFormula = Formula()
        let centerAtom = ElementFactory.create(withSymbol: .C)
        let attachedAtom = ElementFactory.create(withSymbol: .H)
        testFormula.setCenter(element: centerAtom)
        testFormula.addAttached(element: attachedAtom)
        testFormula.updateAttached(element: attachedAtom, value: 4)
        testBondManager = BondManager(withFormula: testFormula)
        
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testNextDisplayTitleOneCenter() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let rule = SkeletonRule(withManager: testBondManager)
        
        let startingTitle = ""
        let nextTitle = "C"
        XCTAssertEqual(rule.nextDisplayTitle(from: startingTitle, at: .center), nextTitle)
        XCTAssertEqual(rule.nextDisplayTitle(from: nextTitle, at: .center), "")
        
    }
    
    func testNextDisplayTitleOneAttached() {
        let rule = SkeletonRule(withManager: testBondManager)
        
        let startingTitle = ""
        let nextTitle = "H"
        XCTAssertEqual(rule.nextDisplayTitle(from: startingTitle, at: .attached), nextTitle)
        XCTAssertEqual(rule.nextDisplayTitle(from: nextTitle, at: .attached), startingTitle)
    }
    
    func testNextDisplayTitleTwoCenter() {
        let testFormula = Formula()
        let centerAtom = ElementFactory.create(withSymbol: .C)
        let attachedAtom = ElementFactory.create(withSymbol: .Cl)
        testFormula.setCenter(element: centerAtom)
        testFormula.addAttached(element: attachedAtom)
        testFormula.updateAttached(element: attachedAtom, value: 4)
        let bondManager = BondManager(withFormula: testFormula)
        let rule = SkeletonRule(withManager: bondManager)
        
        let startingTitle = ""
        let nextTitle = "C"
        let otherTitle = "Cl"
        XCTAssertEqual(rule.nextDisplayTitle(from: startingTitle, at: .center), nextTitle)
        XCTAssertEqual(rule.nextDisplayTitle(from: nextTitle, at: .center), otherTitle)
        XCTAssertEqual(rule.nextDisplayTitle(from: otherTitle, at: .center), startingTitle)
    }
    
    func testNextDisplayTitleTwoEach() {
        let testFormula = Formula()
        let centerAtom = ElementFactory.create(withSymbol: .C)
        let attachedHydrogen = ElementFactory.create(withSymbol: .H)
        let attachedNitrogen = ElementFactory.create(withSymbol: .N)
        testFormula.setCenter(element: centerAtom)
        testFormula.addAttached(element: attachedHydrogen)
        testFormula.addAttached(element: attachedNitrogen)
        let bondManager = BondManager(withFormula: testFormula)
        let rule = SkeletonRule(withManager: bondManager)
        
        let startingCenter = ""
        let nextCenter = "C"
        let otherCenter = "N"
        let startingAttached = ""
        let nextAttached = "H"
        let otherAttached = "N"
        
        XCTAssertEqual(rule.nextDisplayTitle(from: startingCenter, at: .center), nextCenter)
        XCTAssertEqual(rule.nextDisplayTitle(from: nextCenter, at: .center), otherCenter)
        XCTAssertEqual(rule.nextDisplayTitle(from: otherCenter, at: .center), startingCenter)
        
        XCTAssertEqual(rule.nextDisplayTitle(from: startingAttached, at: .attached), nextAttached)
        XCTAssertEqual(rule.nextDisplayTitle(from: nextAttached, at: .attached), otherAttached)
        XCTAssertEqual(rule.nextDisplayTitle(from: otherAttached, at: .attached), startingAttached)
    }
    
//    func testPerformanceExample() {
//        // This is an example of a performance test case.
//        self.measure {
//            // Put the code you want to measure the time of here.
//        }
//    }
    
}
