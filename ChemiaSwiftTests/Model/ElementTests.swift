//
//  ElementTests.swift
//  ChemiaSwift
//
//  Created by Jonah Austin on 3/15/17.
//  Copyright © 2017 edu.bsu. All rights reserved.
//

import XCTest
@testable import ChemiaSwift

class ElementTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testHydrogen() {
        let hydrogen = ElementFactory.create(withSymbol: .H)
        XCTAssertEqual(hydrogen.getSymbol(), "H")
        XCTAssertEqual(hydrogen.numValElectrons(), 1)
    }
    
    func testBoron() {
        let boron = ElementFactory.create(withSymbol: .B)
        XCTAssertEqual(boron.getSymbol(), "B")
        XCTAssertEqual(boron.numValElectrons(), 3)
    }
    
    func testCarbon() {
        let carbon = ElementFactory.create(withSymbol: .C)
        XCTAssertEqual(carbon.getSymbol(), "C")
        XCTAssertEqual(carbon.numValElectrons(), 4)
    }
    
    func testNitrogen() {
        let nitrogen = ElementFactory.create(withSymbol: .N)
        XCTAssertEqual(nitrogen.getSymbol(), "N")
        XCTAssertEqual(nitrogen.numValElectrons(), 5)
    }
    
    func testOxygen() {
        let oxygen = ElementFactory.create(withSymbol: .O)
        XCTAssertEqual(oxygen.getSymbol(), "O")
        XCTAssertEqual(oxygen.numValElectrons(), 6)
    }
    
    func testFluorine() {
        let fluorine = ElementFactory.create(withSymbol: .F)
        XCTAssertEqual(fluorine.getSymbol(), "F")
        XCTAssertEqual(fluorine.numValElectrons(), 7)
    }
    
    func testXenon() {
        let xenon = ElementFactory.create(withSymbol: .Xe)
        XCTAssertEqual(xenon.getSymbol(), "Xe")
        XCTAssertEqual(xenon.numValElectrons(), 8)
    }
    
    func testElementInstancesUnique() {
        let carbon1 = ElementFactory.create(withSymbol: .C)
        let carbon2 = ElementFactory.create(withSymbol: .C)
        
        XCTAssertFalse(carbon1 === carbon2)
    }
    
    
//    func testPerformanceExample() {
//        // This is an example of a performance test case.
//        self.measure {
//            // Put the code you want to measure the time of here.
//        }
//    }
    
}
