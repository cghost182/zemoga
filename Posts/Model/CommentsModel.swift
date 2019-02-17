//
//  CommentsModel.swift
//  Posts
//
//  Created by Christian Collazos on 2/16/19.
//  Copyright © 2019 Christian Collazos. All rights reserved.
//

import Foundation

class CommentsModel : NSObject {
    
    let postId : Int?
    let id: Int?
    let name: String?
    let email : String?
    let body : String?
    
    init(postId:Int, id: Int, name:String, email:String,body:String){
        self.postId = postId
        self.id = id
        self.name = name
        self.email = email
        self.body = body
    }
}
