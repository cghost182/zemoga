//
//  DetailViewController.swift
//  Posts
//
//  Created by Christian Collazos on 2/14/19.
//  Copyright © 2019 Christian Collazos. All rights reserved.
//

import UIKit

protocol updatePostDelegate {
    func setFavorite()
}

class DetailViewController: UIViewController {

    @IBOutlet weak var lbl_postDescription: UILabel!
    @IBOutlet weak var lbl_userName: UILabel!
    @IBOutlet weak var lbl_userEmail: UILabel!
    @IBOutlet weak var lbl_userPhone: UILabel!
    @IBOutlet weak var lbl_userWebsite: UILabel!
    @IBOutlet weak var btn_favorite: UIBarButtonItem!
    
    private var userId : Int?
    private var postDescription : String?
    private var userName : String?
    private var userEmail : String?
    private var userPhone : String?
    private var userWebsite : String?
    private var isFavorite : Bool = false
    var delegate : updatePostDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.lbl_postDescription.text = ""
        self.lbl_userName.text = ""
        self.lbl_userEmail.text = ""
        self.lbl_userPhone.text = ""
        self.lbl_userWebsite.text = ""
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let requestManager = RequestManager(userDelegate: self)
        requestManager.requestUser(userId: self.userId!)
        
        if isFavorite {
            self.btn_favorite.image = UIImage(named: "star-full")
        } else {
            self.btn_favorite.image = UIImage(named: "star")
        }
    }
    
    internal func configureView (postBody : String , userId : Int, isFavorite : Bool){
        self.postDescription = postBody
        self.userId = userId
        self.isFavorite = isFavorite
    }
    
    @IBAction func setFavorite(_ sender: Any) {
        self.isFavorite = !self.isFavorite
        
        if isFavorite {
            self.btn_favorite.image = UIImage(named: "star-full")
        } else {
            self.btn_favorite.image = UIImage(named: "star")
        }
        
        delegate?.setFavorite()
    }
    
}

extension DetailViewController: UserRequestManagerDelegate {
    
    func getUserRequestDidComplete(_ user: UserModel) {
        self.lbl_postDescription.text = self.postDescription
        self.lbl_userName.text = user.name
        self.lbl_userEmail.text = user.email
        self.lbl_userPhone.text = user.phone
        self.lbl_userWebsite.text = user.website
    }
}
