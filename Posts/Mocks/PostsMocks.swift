//
//  PostsMocks.swift
//  PostsTests
//
//  Created by Christian Collazos on 2/16/19.
//  Copyright © 2019 Christian Collazos. All rights reserved.
//

import Foundation

class PostsMocks : NSObject {
    static var postsArray : [PostModel]{
        return [post1,post2,post3]
    }
    
    static var post1 : PostModel {
        get {
            let mockResponse: [String: Any] = ["userId": 1,
                                               "id": 1,
                                               "title": "sunt aut facere repellat provident occaecati excepturi optio reprehenderit",
                                               "body": "quia et suscipit\nsuscipit recusandae consequuntur expedita et cum\nreprehenderit molestiae ut ut quas totam\nnostrum rerum est autem sunt rem eveniet architecto"
            ]
            let post = PostModel(userId: mockResponse["userId"] as! Int, postId: mockResponse["id"] as! Int, title: mockResponse["title"] as! String, body: mockResponse["body"] as! String)
            return post
        }
    }
    
    static var post2 : PostModel {
        get {
            let mockResponse: [String: Any] = ["userId": 2,
                                               "id": 13,
                                               "title": "dolorum ut in voluptas mollitia et saepe quo animi",
                                               "body": "aut dicta possimus sint mollitia voluptas commodi quo doloremque\niste corrupti reiciendis voluptatem eius rerum\nsit cumque quod eligendi laborum minima\nperferendis recusandae assumenda consectetur porro architecto ipsum ipsam"
            ]
            let post = PostModel(userId: mockResponse["userId"] as! Int, postId: mockResponse["id"] as! Int, title: mockResponse["title"] as! String, body: mockResponse["body"] as! String)
            return post
        }
    }
    
    static var post3 : PostModel {
        get {
            let mockResponse: [String: Any] = ["userId": 3,
                                               "id": 24,
                                               "title": "autem hic labore sunt dolores incidunt",
                                               "body": "enim et ex nulla\nomnis voluptas quia qui\nvoluptatem consequatur numquam aliquam sunt\ntotam recusandae id dignissimos aut sed asperiores deserunt"
            ]
            let post = PostModel(userId: mockResponse["userId"] as! Int, postId: mockResponse["id"] as! Int, title: mockResponse["title"] as! String, body: mockResponse["body"] as! String)
            return post
        }
    }
}

