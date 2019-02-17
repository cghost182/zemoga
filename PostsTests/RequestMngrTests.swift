//
//  RequestMngrTests.swift
//  PostsTests
//
//  Created by Christian Collazos on 2/16/19.
//  Copyright © 2019 Christian Collazos. All rights reserved.
//

import XCTest
@testable import Posts

class RequestMngrTests: XCTestCase {
    
    var requestManager: RequestManager?
    var requestManagerMockDelegate: RequestManagerMockDelegate?
    
    override func setUp() {
        requestManagerMockDelegate = RequestManagerMockDelegate()
        requestManager = RequestManager(delegate: requestManagerMockDelegate)
        
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        let asyncExpectation = expectation(description: "delegate call expectation")
        self.requestManagerMockDelegate?.asyncExpectation = asyncExpectation
        
        requestManager?.requestPosts()
        
        waitForExpectations(timeout: 5.0) { error in
            if let error = error {
                XCTFail("waitForExpectations failed: \(error)")
                return
            }
            
            guard let result = self.requestManagerMockDelegate?.expectedResponse else {
                XCTFail("delegate method was not called")
                return
            }
            
            XCTAssertEqual(result.count, 100)
        }
    }
    
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
