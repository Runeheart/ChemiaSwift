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
        let hydrogen = ElementList.hydrogen
        XCTAssertEqual(hydrogen.getSymbol(), "H")
        XCTAssertEqual(hydrogen.numValElectrons(), 2)
    }
    
    func testBoron() {
        let boron = ElementList.boron
        XCTAssertEqual(boron.getSymbol(), "B")
        XCTAssertEqual(boron.numValElectrons(), 3)
    }
    
    func testCarbon() {
        let carbon = ElementList.carbon
        XCTAssertEqual(carbon.getSymbol(), "C")
        XCTAssertEqual(carbon.numValElectrons(), 4)
    }
    
    func testNitrogen() {
        let nitrogen = ElementList.nitrogen
        XCTAssertEqual(nitrogen.getSymbol(), "N")
        XCTAssertEqual(nitrogen.numValElectrons(), 5)
    }
    
    func testOxygen() {
        let oxygen = ElementList.oxygen
        XCTAssertEqual(oxygen.getSymbol(), "O")
        XCTAssertEqual(oxygen.numValElectrons(), 6)
    }
    
    func testFluorine() {
        let fluorine = ElementList.fluorine
        XCTAssertEqual(fluorine.getSymbol(), "F")
        XCTAssertEqual(fluorine.numValElectrons(), 7)
    }
    
    func testXenon() {
        let xenon = ElementList.xenon
        XCTAssertEqual(xenon.getSymbol(), "Xe")
        XCTAssertEqual(xenon.numValElectrons(), 8)
    }
    
    
//    func testPerformanceExample() {
//        // This is an example of a performance test case.
//        self.measure {
//            // Put the code you want to measure the time of here.
//        }
//    }
    
}
