//
//  postCellView.swift
//  Posts
//
//  Created by Christian Collazos on 2/13/19.
//  Copyright © 2019 Christian Collazos. All rights reserved.
//

import Foundation
import SwipeCellKit

class PostCell: SwipeTableViewCell {
    
    @IBOutlet weak var postContent: UILabel!
    @IBOutlet weak var cellIcon: UIImageView!
    
    private var postId : Int = 0
    private var userId : Int = 0
    private var postDetail : String = ""
    private var isFavorite : Bool = false
    
    override func awakeFromNib() {
        
    }
    
    internal func configureCell(with post: PostModel , index : Int) {
        self.postId = post.postId
        self.userId = post.userId
        self.postDetail = post.body
        self.postContent.text = post.title
        self.isFavorite = post.isFavorite
        
        if index <= 20 && !post.visited{
            self.cellIcon.alpha = 1.0
            self.cellIcon.image = UIImage(named: "blue-circle")
        }else if post.visited && post.isFavorite{
            self.cellIcon.alpha = 1.0
            self.cellIcon.image = UIImage(named: "star-full")
        }else {
            self.cellIcon.alpha = 0.0
        }
        
    }
    
    internal func getUserId() -> Int{
        return self.userId
    }
    
    internal func getPostId() -> Int{
        return self.postId
    }
    
    internal func getPostDetail() -> String{
        return self.postDetail
    }
    
    internal func getPostFavorite() -> Bool{
        return self.isFavorite
    }

    
}
