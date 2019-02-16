//
//  DetailsViewModel.swift
//  Posts
//
//  Created by Christian Collazos on 2/16/19.
//  Copyright © 2019 Christian Collazos. All rights reserved.
//

import Foundation

protocol DetailsViewModel {
    var postBody : String {get set}
    var postIsFavorite : Bool {get set}
    var userId : Int {get set}
    
    func setUser(user:UserModel)
    func getUserName() -> String
    func getUserEmail() -> String
    func getUserPhone() -> String
    func getUSerWebsite() -> String
    func toggleFavorite()
}
