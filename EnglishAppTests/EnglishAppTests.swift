//
//  EnglishAppTests.swift
//  EnglishAppTests
//
//  Created by 大城昂希 on 2019/10/19.
//

import XCTest
@testable import EnglishApp

class EnglishAppTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testGetAlphabet() {
        //お題N番目が取れるかのテストをする
        let appController = ApplicationController()
        appController.question = "dog"
        XCTAssertEqual(appController.getAlphabet(index: 0), "d")
        XCTAssertEqual(appController.getAlphabet(index: 1), "o")
        XCTAssertEqual(appController.getAlphabet(index: 2), "g")
    }
    
    func testCheckQuestionAlphabetInIdentifier() {
        let appController = ApplicationController()
        XCTAssertEqual(appController.checkObjectNameAndQuestion(identifier: "Hoge", targetAlphabet: "H"), Optional(true))
        XCTAssertEqual(appController.checkObjectNameAndQuestion(identifier: "Hoge", targetAlphabet: "h"), Optional(true))
        XCTAssertEqual(appController.checkObjectNameAndQuestion(identifier: "Hoge", targetAlphabet: "G"), Optional(true))
        XCTAssertEqual(appController.checkObjectNameAndQuestion(identifier: "Hoge", targetAlphabet: "g"), Optional(true))
        XCTAssertEqual(appController.checkObjectNameAndQuestion(identifier: "Hoge", targetAlphabet: "F"), Optional(false))
        XCTAssertEqual(appController.checkObjectNameAndQuestion(identifier: "Hoge", targetAlphabet: "f"), Optional(false))
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
