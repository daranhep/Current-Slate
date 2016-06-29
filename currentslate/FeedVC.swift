//
//  FeedVC.swift
//  currentslate
//
//  Created by Dara Nhep on 6/13/16.
//  Copyright © 2016 Dara Nhep. All rights reserved.
//

import UIKit
import DTTableViewManager
import DTModelStorage
import Firebase
import FirebaseStorage
import FirebaseDatabase

class FeedVC: UIViewController, DTTableViewManageable, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    var posts = [Post]()
    
    var postRef: FIRDatabaseReference!
    var refHandle: FIRDatabaseHandle?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.postRef = FIRDatabase.database().reference()
        
        refHandle = postRef.child("posts").observeEventType(FIRDataEventType.Value, withBlock: { (snapshot) in
            print(snapshot.value)
            
            self.posts = []
            self.manager.startManagingWithDelegate(self)
            self.manager.registerCellClass(PostCell)
            if let snapshots = snapshot.children.allObjects as? [FIRDataSnapshot] {
                
                for snap in snapshots {
                    print("Snap:  \(snap)")
                    
                    if let postDict = snap.value as? Dictionary<String, AnyObject> {
                        let key = snap.key
                        let post = Post(postKey: key, dictionary: postDict)
                        self.posts.append(post)
                    }
                    
                }
                
                print("we the best2\(self.posts.count)")
            }
            self.manager.memoryStorage.addItems(self.posts)
            
        })
        

        manager.startManagingWithDelegate(self)
        manager.registerCellClass(PostCell)
        
//        let foo = ["wethebest","wethebest"]
        
//        manager.memoryStorage.addItems(posts)
        
        print("we the best\(posts.count)")
        
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        if let refHandle = refHandle {
            postRef.removeObserverWithHandle(refHandle)
        }
        
        print("left the view")
        
    }
    
//    func selectedPost(cell: PostCell, post: Post, indexPath: NSIndexPath) {
//        let post = posts[indexPath.row]
//        print(post.imageURL)
//    }


}
