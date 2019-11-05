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

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        // dataStorageにデータを登録できるかテストする
        let dataStorage: QuestionDataSingleton = QuestionDataSingleton.sharedInstance
        dataStorage.saveUsedText(usedText: "Question")
        XCTAssertEqual(dataStorage.getUsedTextList(), ["Question"])
        dataStorage.saveUsedText(usedText: "Hoge")
        XCTAssertEqual(dataStorage.getUsedTextList(), ["Question", "Hoge"])
        // dataStorageでデータがシェアできるかテストする
        let dataStorage2: QuestionDataSingleton = QuestionDataSingleton.sharedInstance
        XCTAssertEqual(dataStorage2.getUsedTextList(), ["Question", "Hoge"])
        dataStorage2.saveUsedText(usedText: "Fuga")
        XCTAssertEqual(dataStorage.getUsedTextList(), ["Question", "Hoge", "Fuga"])
        
        //お題N番目が取れるかのテストをする
        var questionViewController = QuestionViewController()
        questionViewController.question = "dog"
        XCTAssertEqual(questionViewController.getAlphabet(index: 0), "d")
        XCTAssertEqual(questionViewController.getAlphabet(index: 1), "o")
        XCTAssertEqual(questionViewController.getAlphabet(index: 2), "g")

    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
