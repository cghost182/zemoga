//
//  PostsTests.swift
//  PostsTests
//
//  Created by Christian Collazos on 2/13/19.
//  Copyright © 2019 Christian Collazos. All rights reserved.
//

import XCTest
@testable import Posts

class PostsTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testPostsModel() {
        let post = PostsMocks.post1
        XCTAssertNotNil(post)
        XCTAssertEqual(post.userId, 1)
        XCTAssertEqual(post.postId, 1)
        XCTAssertEqual(post.title, "sunt aut facere repellat provident occaecati excepturi optio reprehenderit")
        XCTAssertEqual(post.body, "quia et suscipit\nsuscipit recusandae consequuntur expedita et cum\nreprehenderit molestiae ut ut quas totam\nnostrum rerum est autem sunt rem eveniet architecto")
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
