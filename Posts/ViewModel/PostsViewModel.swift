//
//  PostsViewModel.swift
//  Posts
//
//  Created by Christian Collazos on 2/15/19.
//  Copyright © 2019 Christian Collazos. All rights reserved.
//

import Foundation


protocol PostViewModel {
    func getPosts() -> [PostModel]
    func setPosts(posts : [PostModel])
    func getPost(index : Int) -> PostModel
    func getPostsCount() -> Int
    func toggleFavorite(with index: Int)
    func setVisited(index:Int)
}
