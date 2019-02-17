//
//  ViewController.swift
//  Posts
//
//  Created by Christian Collazos on 2/13/19.
//  Copyright © 2019 Christian Collazos. All rights reserved.
//

import UIKit
import SwipeCellKit

class ViewController: UIViewController {
  
    var currentIndex : Int = 0
    var defaultOptions = SwipeOptions()
    var buttonDisplayMode: ButtonDisplayMode = .titleAndImage
    var buttonStyle: ButtonStyle = .backgroundColor
    var postsViewModel: PostViewModel = PostViewModelImplementation()

    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var postsTableView: UITableView!
    @IBOutlet weak var btn_delete: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.barTintColor = UIColor.green
        postsTableView.allowsSelection = true
        postsTableView.allowsMultipleSelectionDuringEditing = true
        postsTableView.rowHeight = 50.0
        loadPosts()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        postsTableView.reloadData()
    }
    
    private func loadPosts(){
        let requestManager = RequestManager(delegate: self)
        requestManager.requestPosts()
    }

    // Action for segmentedControl
    @IBAction func indexChanged(_ sender: UISegmentedControl) {
        var animateOption : UIView.AnimationOptions?
        
        switch sender.selectedSegmentIndex
        {
        case 0:
            postsViewModel.showAllPosts()
            animateOption = .transitionFlipFromLeft
        case 1:
            postsViewModel.filterOnlyFavoritePosts()
            animateOption = .transitionFlipFromRight
        default:
            break
        }
        
        UIView.transition(with: postsTableView, duration: 1.0, options: animateOption!, animations: { [weak self] in
            self!.postsTableView.reloadData()
            }, completion: nil
        )
        
    }
    
    @IBAction func deleteAllAction(_ sender: Any) {
        postsViewModel.deleteAllPosts()
        
        UIView.animate(withDuration: 0.5, delay: 0, options: .transitionFlipFromTop, animations: {
            self.btn_delete.frame = CGRect(x: self.btn_delete.frame.origin.x, y: self.btn_delete.frame.origin.y, width: self.btn_delete.frame.width, height: 0)
        }, completion: nil)
        
        postsTableView.reloadData()
    }
    
    @IBAction func reloadAllPosts(_ sender: Any) {
        segmentedControl.selectedSegmentIndex = 0
        
        UIView.animate(withDuration: 0.5, delay: 0, options: .transitionFlipFromBottom, animations: {
            self.btn_delete.frame = CGRect(x: self.btn_delete.frame.origin.x, y: self.btn_delete.frame.origin.y, width: self.btn_delete.frame.width, height: 34)
        }, completion: nil)
        
        loadPosts()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.destination is DetailViewController
        {
            let currentPost = sender as! PostCell
            let detailVC = segue.destination as? DetailViewController
            detailVC?.viewModel = DetailsViewModelImplementation()
            detailVC?.viewModel?.postBody = currentPost.getPostDetail()
            detailVC?.viewModel?.postIsFavorite = currentPost.getPostFavorite()
            detailVC?.viewModel?.userId = currentPost.getUserId()
            detailVC?.viewModel?.postId = currentPost.getPostId()
            detailVC?.delegate = self
        }
    }
    
}



// MARK: - Extensions

extension ViewController : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postsViewModel.getPostsCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCellID") as! PostCell
        cell.delegate = self
        cell.configureCell(with: postsViewModel.getPost(index:indexPath.row), index: indexPath.row)
        
        return cell
    }
}

extension ViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        currentIndex = indexPath.row
        postsViewModel.setVisited(index : currentIndex)
        postsTableView.reloadData()
    }
}

extension ViewController: RequestManagerDelegate {
    func getPostsRequestDidComplete(_ responsePosts: [PostModel]) {
        postsViewModel.setPosts(posts: responsePosts)
        DispatchQueue.main.async { [weak self] in
            self?.postsTableView.reloadData()
        }
    }

}

extension ViewController: updatePostDelegate {
    func toggleFavorite() {
        postsViewModel.toggleFavorite(with:currentIndex)
    }
    
}

extension ViewController: SwipeTableViewCellDelegate {
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        let post = postsViewModel.getPost(index: indexPath.row)
        guard orientation == .right else { return nil }
        
        let deleteAction = SwipeAction(style: .destructive, title: "Delete") { action, indexPath in
            // handle action by updating model with deletion
            self.postsViewModel.deletePost(at: indexPath.row)
        }
        configure(action: deleteAction, with: .trash)
        
        
        return [deleteAction]
    }
    
    func tableView(_ tableView: UITableView, editActionsOptionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> SwipeOptions {
        var options = SwipeOptions()
        options.expansionStyle = .destructive
        options.transitionStyle = .border
        return options
    }
    
    func configure(action: SwipeAction, with descriptor: ActionDescriptor) {
        action.title = descriptor.title(forDisplayMode: buttonDisplayMode)
        action.image = descriptor.image(forStyle: buttonStyle, displayMode: buttonDisplayMode)

        switch buttonStyle {
        case .backgroundColor:
            action.backgroundColor = descriptor.color
        case .circular:
            action.backgroundColor = .clear
            action.textColor = descriptor.color
            action.font = .systemFont(ofSize: 13)
            action.transitionDelegate = ScaleTransition.default
        }
    }
}

