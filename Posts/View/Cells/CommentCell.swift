//
//  CommentCell.swift
//  Posts
//
//  Created by Christian Collazos on 2/16/19.
//  Copyright © 2019 Christian Collazos. All rights reserved.
//

import UIKit

class CommentCell: UITableViewCell {
    
    @IBOutlet weak var lbl_comment: UILabel!
    
    override func awakeFromNib() {
        
    }
    
    internal func configureCell(with commentBody: String ) {
        lbl_comment.text = commentBody
    }
}
