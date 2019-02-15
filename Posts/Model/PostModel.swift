//
//  PostModel.swift
//  Posts
//
//  Created by Christian Collazos on 2/13/19.
//  Copyright © 2019 Christian Collazos. All rights reserved.
//

import Foundation

class PostModel {
    let userId : Int
    let postId: Int
    let title: String
    let body: String
    var visited : Bool
    var isFavorite : Bool
    
    
    init(userId: Int, postId: Int, title: String, body: String, visited : Bool? = false, isFavorite : Bool? = false) {
        self.userId = userId
        self.postId = postId
        self.title = title
        self.body = body
        self.visited = visited!
        self.isFavorite = isFavorite!
    }
    
    internal func setVisited (){
        self.visited = true
    }
    
    internal func setFavorite (){
        self.isFavorite = !self.isFavorite
    }
    
}
