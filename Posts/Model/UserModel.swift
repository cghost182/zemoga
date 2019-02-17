//
//  UserModel.swift
//  Posts
//
//  Created by Christian Collazos on 2/14/19.
//  Copyright © 2019 Christian Collazos. All rights reserved.
//

import Foundation

class UserModel : NSObject{
    let userId: Int
    let name: String
    let email: String
    let phone: String
    var website : String
    
    init(userId: Int, name: String, email: String, phone : String, website : String) {
        self.userId = userId
        self.name = name
        self.email = email
        self.phone = phone
        self.website = website
    }

}
