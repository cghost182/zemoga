//
//  DetailViewController.swift
//  Posts
//
//  Created by Christian Collazos on 2/14/19.
//  Copyright © 2019 Christian Collazos. All rights reserved.
//

import UIKit

protocol updatePostDelegate {
    func toggleFavorite()
}

class DetailViewController: UIViewController {

    @IBOutlet weak var lbl_postDescription: UILabel!
    @IBOutlet weak var lbl_userName: UILabel!
    @IBOutlet weak var lbl_userEmail: UILabel!
    @IBOutlet weak var lbl_userPhone: UILabel!
    @IBOutlet weak var lbl_userWebsite: UILabel!
    @IBOutlet weak var btn_favorite: UIBarButtonItem!
    
    var viewModel : DetailsViewModel?
    var delegate : updatePostDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        guard let viewModel = viewModel else{
            return
        }
        
        //You can test with network conditioner in very bad network to see this 'Loading...' texts working
        self.lbl_postDescription.text = "Loading..."
        self.lbl_userName.text = "Loading..."
        self.lbl_userEmail.text = "Loading..."
        self.lbl_userPhone.text = "Loading..."
        self.lbl_userWebsite.text = "Loading..."
        
        let requestManager = RequestManager(userDelegate: self)
        requestManager.requestUser(userId: viewModel.userId)
        
        if viewModel.postIsFavorite {
            self.btn_favorite.image = UIImage(named: "star-full")
        } else {
            self.btn_favorite.image = UIImage(named: "star")
        }
    }

    
    @IBAction func setFavorite(_ sender: Any) {
        
        guard let viewModel = viewModel else{
            return
        }
        
        viewModel.toggleFavorite()
        
        if viewModel.postIsFavorite {
            self.btn_favorite.image = UIImage(named: "star-full")
        } else {
            self.btn_favorite.image = UIImage(named: "star")
        }
        
        delegate?.toggleFavorite()
    }
    
}

extension DetailViewController: UserRequestManagerDelegate {
    
    func getUserRequestDidComplete(_ user: UserModel) {
        guard let viewModel = viewModel else{
            return
        }
        
        viewModel.setUser(user: user)
        
        DispatchQueue.main.async { [weak self] in
            self?.lbl_postDescription.text = viewModel.postBody
            self?.lbl_userName.text = viewModel.getUserName()
            self?.lbl_userEmail.text = viewModel.getUserEmail()
            self?.lbl_userPhone.text = viewModel.getUserPhone()
            self?.lbl_userWebsite.text = viewModel.getUSerWebsite()
        }
        
    }
}
