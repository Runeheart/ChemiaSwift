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
    var rule: ValenceRule = ValenceRule()
    var answers: [Answer] = []
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        formula = Formula()
        formula.setCenter(element: ElementFactory.create(withSymbol: .C))
        formula.addAttached(element: ElementFactory.create(withSymbol: .O))
        
        rule = ValenceRule(withFormula: formula)
        answers = rule.getPossibleAnswers()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testCorrectAnswerIsGenerated() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        XCTAssertEqual(answers[0].content, 10)
    }
    
    func testIncorrectAnswersAreGenerated() {
        
        let correctChoice = answers[0].content
        var wrongAnswerCount = 0
        for choice in answers {
            let givenValue = choice.content
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
