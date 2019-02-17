//
//  RequestManagerMockDelegate.swift
//  PostsTests
//
//  Created by Christian Collazos on 2/16/19.
//  Copyright © 2019 Christian Collazos. All rights reserved.
//

import XCTest
@testable import Posts

class RequestManagerMockDelegate: RequestManagerDelegate {
    
    var asyncExpectation: XCTestExpectation?
    var expectedResponse: [PostModel]?
    
   func getPostsRequestDidComplete(_ responsePosts: [PostModel]) {
        guard let expectation = asyncExpectation else {
            return
        }
        
        expectedResponse = responsePosts
        expectation.fulfill()
    }
    
}
