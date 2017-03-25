//
//  FormulaTests.swift
//  ChemiaSwift
//
//  Created by Jonah Austin on 3/15/17.
//  Copyright © 2017 edu.bsu. All rights reserved.
//

import XCTest
@testable import ChemiaSwift

class FormulaTests: XCTestCase {
    
    var formula: Formula = Formula()
    var carbon: Element = Element()
    var hydrogen: Element = Element()
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        formula = Formula()
        carbon = ElementFactory.create(withSymbol: .C)
        hydrogen = ElementFactory.create(withSymbol: .H)
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testAddingCenterElement() {
        
        formula.setCenter(element: carbon)
        
        XCTAssertEqual(formula.simpleForm(), "C")
        
    }
    
    func testAddingAttachedElement() {
        
        formula.setCenter(element: carbon)
        formula.addAttached(element: hydrogen)
        
        XCTAssertEqual(formula.simpleForm(), "CH")
        
    }
    
    func testAddingSecondAttachedElement() {
        
        formula.setCenter(element: carbon)
        formula.addAttached(element: hydrogen)
        formula.updateAttached(element: hydrogen, value: 2)
        
        XCTAssertEqual(formula.simpleForm(), "CH2")
    }
    
    func testValenceCalculation() {
        
        formula.setCenter(element: carbon)
        formula.addAttached(element: hydrogen)
        formula.updateAttached(element: hydrogen, value: 4)
        
        let testValenceTotal = formula.calculateValence()
        XCTAssertEqual(testValenceTotal, 8)
    }
    
    func testNumberOfAtoms() {
        
        formula.setCenter(element: carbon)
        formula.addAttached(element: hydrogen)
        formula.updateAttached(element: hydrogen, value: 4)
        
        let testAtomTotal = formula.numberOfAtoms()
        XCTAssertEqual(testAtomTotal, 5)
    }
    
    func testValenceBreakdown() {
        
        formula.setCenter(element: carbon)
        formula.addAttached(element: hydrogen)
        formula.updateAttached(element: hydrogen, value: 4)
        
        let testValenceCoefficients = formula.valenceBreakdown()
        XCTAssertEqual(testValenceCoefficients[0].0, 1)
        XCTAssertEqual(testValenceCoefficients[0].1, 4)
        XCTAssertEqual(testValenceCoefficients[1].0, 4)
        XCTAssertEqual(testValenceCoefficients[1].1, 1)
    }
    
    func testElementsArray() {
        
        formula.setCenter(element: carbon)
        formula.addAttached(element: hydrogen)
        formula.updateAttached(element: hydrogen, value: 4)
        
        let testElementArray = formula.elementsArray()
        XCTAssertEqual(testElementArray.count, formula.numberOfAtoms())
        XCTAssert(testElementArray[0] == carbon)
        XCTAssert(testElementArray[1] == hydrogen)
        XCTAssert(testElementArray[2] == hydrogen)
        XCTAssert(testElementArray[3] == hydrogen)
        XCTAssert(testElementArray[4] == hydrogen)
    }
    
//    func testPerformanceExample() {
//        // This is an example of a performance test case.
//        self.measure {
//            // Put the code you want to measure the time of here.
//        }
//    }
    
}
