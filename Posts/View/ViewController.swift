//
//  ViewController.swift
//  Posts
//
//  Created by Christian Collazos on 2/13/19.
//  Copyright © 2019 Christian Collazos. All rights reserved.
//

import UIKit
import SwipeCellKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
  
    var posts : [PostModel] = []
    var currentIndex : Int = 0
    var defaultOptions = SwipeOptions()

    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var postsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.barTintColor = UIColor.green
        postsTableView.allowsSelection = true
        postsTableView.allowsMultipleSelectionDuringEditing = true
        postsTableView.rowHeight = 50.0
        
        let requestManager = RequestManager(delegate: self)
        requestManager.requestPosts()
    }

    @IBAction func indexChanged(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex
        {
        case 0:
            postsTableView.isHidden = true
        case 1:
            postsTableView.isHidden = false
        default:
            break
        }
    }
    
    @IBAction func deleteAllAction(_ sender: Any) {
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCellID") as! PostCell
        cell.delegate = self 
        cell.configureCell(with: posts[indexPath.row], index: indexPath.row)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        currentIndex = indexPath.row
        posts[currentIndex].setVisited()
        postsTableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.destination is DetailViewController
        {
            let currentPost = sender as! PostCell
            let vc = segue.destination as? DetailViewController
            vc?.delegate = self
            
            vc?.configureView(postBody: currentPost.getPostDetail(), userId: currentPost.getUserId(), isFavorite: currentPost.getPostFavorite())
        }
    }
    
}

// MARK: - Request Manager Delegate

extension ViewController: RequestManagerDelegate {
    func getPostsRequestDidComplete(_ responsePosts: [PostModel]) {
        posts = responsePosts
        DispatchQueue.main.async { [weak self] in
            self?.postsTableView.reloadData()
        }
    }

}

extension ViewController: updatePostDelegate {
    func setFavorite() {
        posts[currentIndex].setFavorite()
        DispatchQueue.main.async { [weak self] in
            self?.postsTableView.reloadData()
        }
    }
}

extension ViewController: SwipeTableViewCellDelegate {
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        let post = posts[indexPath.row]
        
//        if orientation == .left {
//            guard isSwipeRightEnabled else { return nil }
//
//            let read = SwipeAction(style: .default, title: nil) { action, indexPath in
//                let updatedStatus = !email.unread
//                email.unread = updatedStatus
//
//                let cell = tableView.cellForRow(at: indexPath) as! MailCell
//                cell.setUnread(updatedStatus, animated: true)
//            }
//
//            read.hidesWhenSelected = true
//            read.accessibilityLabel = email.unread ? "Mark as Read" : "Mark as Unread"
//
//            let descriptor: ActionDescriptor = email.unread ? .read : .unread
//            configure(action: read, with: descriptor)
//
//            return [read]
//        } else {
//            let flag = SwipeAction(style: .default, title: nil, handler: nil)
//            flag.hidesWhenSelected = true
//            configure(action: flag, with: .flag)
//
//            let delete = SwipeAction(style: .destructive, title: nil) { action, indexPath in
//                self.emails.remove(at: indexPath.row)
//            }
//            configure(action: delete, with: .trash)
//
//            let cell = tableView.cellForRow(at: indexPath) as! MailCell
//            let closure: (UIAlertAction) -> Void = { _ in cell.hideSwipe(animated: true) }
//            let more = SwipeAction(style: .default, title: nil) { action, indexPath in
//                let controller = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
//                controller.addAction(UIAlertAction(title: "Reply", style: .default, handler: closure))
//                controller.addAction(UIAlertAction(title: "Forward", style: .default, handler: closure))
//                controller.addAction(UIAlertAction(title: "Mark...", style: .default, handler: closure))
//                controller.addAction(UIAlertAction(title: "Notify Me...", style: .default, handler: closure))
//                controller.addAction(UIAlertAction(title: "Move Message...", style: .default, handler: closure))
//                controller.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: closure))
//                self.present(controller, animated: true, completion: nil)
//            }
//            configure(action: more, with: .more)
//
//            return [delete, flag, more]
//        }
        return []
    }
    
    func tableView(_ tableView: UITableView, editActionsOptionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> SwipeOptions {
        var options = SwipeOptions()
        options.expansionStyle = orientation == .left ? .selection : .destructive
        options.transitionStyle = defaultOptions.transitionStyle
        
//        switch buttonStyle {
//        case .backgroundColor:
//            options.buttonSpacing = 11
//        case .circular:
//            options.buttonSpacing = 4
//            options.backgroundColor = #colorLiteral(red: 0.9467939734, green: 0.9468161464, blue: 0.9468042254, alpha: 1)
//        }
        
        return options
    }
    
//    func configure(action: SwipeAction, with descriptor: ActionDescriptor) {
//        action.title = descriptor.title(forDisplayMode: buttonDisplayMode)
//        action.image = descriptor.image(forStyle: buttonStyle, displayMode: buttonDisplayMode)
//
//        switch buttonStyle {
//        case .backgroundColor:
//            action.backgroundColor = descriptor.color
//        case .circular:
//            action.backgroundColor = .clear
//            action.textColor = descriptor.color
//            action.font = .systemFont(ofSize: 13)
//            action.transitionDelegate = ScaleTransition.default
//        }
//    }
}

