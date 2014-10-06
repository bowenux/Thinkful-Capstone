//
//  Capstone_01Tests.swift
//  Capstone 01Tests
//
//  Created by Rick Bowen on 10/2/14.
//  Copyright (c) 2014 Rick Bowen. All rights reserved.
//

import UIKit
import XCTest

class Capstone_01Tests: XCTestCase {
    
    var client = APIClient()
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
//    func testExample() {
//        // This is an example of a functional test case.
//        XCTAssert(true, "Pass")
//    }
//    
//    func testPerformanceExample() {
//        // This is an example of a performance test case.
//        self.measureBlock() {
//            // Put the code you want to measure the time of here.
//        }
//    }
    
    func testAudio() {
        
        let apiExpectation = expectationWithDescription("request audio")
        
        
        client.getAudio({ (response :AnyObject) in
            
            println("response - \(response)")
            apiExpectation.fulfill()
            }, failure: {
                (error :NSError) in
                
                println("error - \(error)")
        })
        
        waitForExpectationsWithTimeout(5,
            handler:{
                error in
                
        })
    }
    
}
