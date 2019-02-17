//
//  DetailsViewModelImplementation.swift
//  Posts
//
//  Created by Christian Collazos on 2/16/19.
//  Copyright © 2019 Christian Collazos. All rights reserved.
//

import Foundation

class DetailsViewModelImplementation : NSObject, DetailsViewModel {
    var postId: Int = 0
    var postBody : String = ""
    var postIsFavorite : Bool = false
    var userId : Int = 0
    
    private var user : UserModel?
    
    override init() {
        super.init()
    }
    
    func setUser(user:UserModel){
        self.user = user
    }
    
    func getUser(userId:Int) -> UserModel{
        return self.user!
    }
    
    func getUserName() -> String{
        return self.user!.name
    }
    
    func getUserEmail() -> String{
        return self.user!.email
    }
    
    func getUserPhone() -> String{
        return self.user!.phone
    }
    
    func getUSerWebsite() -> String{
        return self.user!.website
    }
    
    func toggleFavorite(){
     self.postIsFavorite = !self.postIsFavorite
    }
}
