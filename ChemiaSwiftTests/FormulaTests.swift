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
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        formula = Formula()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testAddsInitialElement() {
        
        formula.add(element: ElementList.hydrogen)
        
        XCTAssertEqual(formula.simpleForm(), "H")
        
    }
    
    func testAddingSecondUniqueElement() {
        
        formula.add(element: ElementList.carbon)
        formula.add(element: ElementList.hydrogen)
        
        XCTAssertEqual(formula.simpleForm(), "CH")
        
    }
    
    func testAddingSecondOfPresentElement() {
        
        formula.add(element: ElementList.oxygen)
        formula.updateElement(element: ElementList.oxygen, value: 2)
        
        XCTAssertEqual(formula.simpleForm(), "O2")
    }
    
    func testValenceCalculation() {
        
        formula.add(element: ElementList.carbon)
        formula.add(element: ElementList.hydrogen)
        formula.updateElement(element: ElementList.hydrogen, value: 4)
        
        let testValenceTotal = formula.calculateValence()
        XCTAssertEqual(testValenceTotal, 8)
    }
    
    func testNumberOfAtoms() {
        
        formula.add(element: ElementList.carbon)
        formula.add(element: ElementList.hydrogen)
        formula.updateElement(element: ElementList.hydrogen, value: 4)
        
        let testAtomTotal = formula.numberOfAtoms()
        XCTAssertEqual(testAtomTotal, 5)
    }
    
    func testValenceBreakdown() {
        
        formula.add(element: ElementList.carbon)
        formula.add(element: ElementList.hydrogen)
        formula.updateElement(element: ElementList.hydrogen, value: 4)
        
        let testValenceCoefficients = formula.valenceBreakdown()
        XCTAssertEqual(testValenceCoefficients[0].0, 1)
        XCTAssertEqual(testValenceCoefficients[0].1, 4)
        XCTAssertEqual(testValenceCoefficients[1].0, 4)
        XCTAssertEqual(testValenceCoefficients[1].1, 1)
    }
    
    func testElementsArray() {
        
        formula.add(element: ElementList.carbon)
        formula.add(element: ElementList.hydrogen)
        formula.updateElement(element: ElementList.hydrogen, value: 4)
        
        let testElementArray = formula.elementsArray()
        XCTAssertEqual(testElementArray.count, formula.numberOfAtoms())
        XCTAssert(testElementArray[0] === ElementList.carbon)
        XCTAssert(testElementArray[1] === ElementList.hydrogen)
        XCTAssert(testElementArray[2] === ElementList.hydrogen)
        XCTAssert(testElementArray[3] === ElementList.hydrogen)
        XCTAssert(testElementArray[4] === ElementList.hydrogen)
    }
    
//    func testPerformanceExample() {
//        // This is an example of a performance test case.
//        self.measure {
//            // Put the code you want to measure the time of here.
//        }
//    }
    
}
