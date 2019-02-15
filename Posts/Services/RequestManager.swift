//
//  RequestManager.swift
//  Workportal Inbox
//
//  Created by trink2 on 9/5/17.
//  Copyright © 2017 Bizagi. All rights reserved.
//

import Foundation

protocol RequestManagerDelegate {
    func getPostsRequestDidComplete(_ responsePosts: [PostModel])
}
protocol UserRequestManagerDelegate {
    func getUserRequestDidComplete(_ user:UserModel)
}

class RequestManager: NSObject {
    
    let postsEndpoint = "https://jsonplaceholder.typicode.com/posts"
    let userEndpoint = "https://jsonplaceholder.typicode.com/users"
    
    var delegate: RequestManagerDelegate?
    var userDelegate : UserRequestManagerDelegate?
    
    init(delegate: RequestManagerDelegate? = nil, userDelegate : UserRequestManagerDelegate? = nil) {
        super.init()
        self.delegate = delegate
        self.userDelegate = userDelegate
    }

    func requestPosts() {
        
        let task = URLSession.shared.dataTask(with: performRequest(with: URL(string: postsEndpoint)!)) { data, response, error in
            guard error == nil else {
                return
            }
            
            guard let data = data else {
                return
            }
            
            self.delegate?.getPostsRequestDidComplete(self.parsePostsRequest(data))
        }
        
        task.resume()
    }
    
    func requestUser(userId : Int) {
        
        let task = URLSession.shared.dataTask(with: performRequest(with: URL(string: "\(userEndpoint)/\(userId)")!)) { data, response, error in
            guard error == nil else {
                return
            }
            
            guard let data = data else {
                return
            }
            
            self.userDelegate?.getUserRequestDidComplete(self.parseUserRequest(data))
        }
        
        task.resume()
    }
    
    fileprivate func performRequest(with url : URL) -> URLRequest {
        var request = URLRequest(url: url)
        request.addValue("application/json", forHTTPHeaderField: "Content-type")
        return request
    }
    
    
    //MARK: - Parsing posts
    fileprivate func parsePostsRequest(_ data: Data) -> [PostModel] {
        do {
            let jsonResponse = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers)
            
            guard let arrayResponse = jsonResponse as? [Any] else {
                return []
            }
            
            return self.parsePosts(from: arrayResponse)
        } catch {
            return []
        }
    }
    
    fileprivate func parsePosts(from arrayResponse: [Any]) -> [PostModel] {
        
        var postsArray: [PostModel] = []
        
        for postResponse in arrayResponse {
            guard let post = postResponse as? [String : Any] else {
                continue
            }
            
            //TODO use codable
            postsArray.append(PostModel(userId: post["userId"] as! Int, postId: post["id"] as! Int, title: post["title"] as! String, body: post["body"] as! String))
        }
        
        return postsArray
    }
    
    //MARK: - Parsing user
    fileprivate func parseUserRequest(_ data: Data) -> UserModel {
        do {
            let jsonResponse = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers)
            
            guard let userResponse = jsonResponse as? Any else {
                return  UserModel(userId: 0, name: "", email: "", phone: "", website: "")
            }
            
            return self.parseUser(from: userResponse)
        } catch {
            return UserModel(userId: 0, name: "", email: "", phone: "", website: "")
        }
    }
    
    fileprivate func parseUser(from userResponse: Any) -> UserModel {
        
        guard let _user = userResponse as? [String : Any] else {
            return  UserModel(userId: 0, name: "", email: "", phone: "", website: "")
        }
        
        //TODO use codable
        return UserModel(userId: _user["id"] as! Int, name: _user["name"] as! String, email: _user["email"] as! String, phone: _user["phone"] as! String, website: _user["website"] as! String)
    }
}

