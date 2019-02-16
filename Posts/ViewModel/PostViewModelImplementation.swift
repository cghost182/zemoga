//
//  PostViewModelImplementation.swift
//  Posts
//
//  Created by Christian Collazos on 2/15/19.
//  Copyright © 2019 Christian Collazos. All rights reserved.
//

import Foundation

class PostViewModelImplementation : NSObject, PostViewModel {
    private var posts : [PostModel] = []
    private var tempPosts : [PostModel] = []
    
    override init() {
        super.init()
    }
    
    func getPosts() -> [PostModel] {
        return self.posts
    }
    
    func setPosts(posts : [PostModel]){
        self.posts = posts
    }
    
    func getPost(index : Int) -> PostModel{
        return self.posts[index]
    }
    
    func getPostsCount() -> Int {
        return self.posts.count
    }
    
    func toggleFavorite(with index: Int) {
        posts[index].toggleFavorite()
    }
    
    func setVisited(index:Int){
        posts[index].setVisited()
    }
    
    func filterOnlyFavoritePosts() {
        tempPosts = posts
        posts =  posts.filter { $0.isFavorite == true }
    }
    
    func showAllPosts() {
        posts = tempPosts
    }
    
    func deleteAllPosts(){
        posts = []
        tempPosts = []
    }
    
    func deletePost( at index : Int) {
        posts.remove(at: index)
    }
    
}
