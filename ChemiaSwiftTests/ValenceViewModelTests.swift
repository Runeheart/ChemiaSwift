//
//  ValenceViewModelTests.swift
//  ChemiaSwift
//
//  Created by Jonah Austin on 3/15/17.
//  Copyright © 2017 edu.bsu. All rights reserved.
//

import XCTest
@testable import ChemiaSwift

class ValenceViewModelTests: XCTestCase {
    
    var formula: Formula = Formula()
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        formula = Formula()
        formula.add(element: ElementFactory.create(withSymbol: .C))
        formula.add(element: ElementFactory.create(withSymbol: .O))
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testCorrectAnswerIsGenerated() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        let rule = ValenceRule(withFormula: formula)
        let answers: [Answer] = rule.getPossibleAnswers()
        XCTAssertEqual(answers[0].content as! Int, 10)
    }
    
    func testIncorrectAnswersAreGenerated() {
        
        let rule = ValenceRule(withFormula: formula)
        let answers: [Answer] = rule.getPossibleAnswers()
        
        let correctChoice = answers[0].content as! Int
        var wrongAnswerCount = 0
        for choice in answers {
            let givenValue = choice.content as! Int
            if givenValue != correctChoice {
                wrongAnswerCount += 1
            }
        }
        
        XCTAssertEqual(wrongAnswerCount, 4)
    }
    
//    func testPerformanceExample() {
//        // This is an example of a performance test case.
//        self.measure {
//            // Put the code you want to measure the time of here.
//        }
//    }
    
}
