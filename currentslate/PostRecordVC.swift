//
//  PostRecordVC.swift
//  currentslate
//
//  Created by Dara Nhep on 6/16/16.
//  Copyright © 2016 Dara Nhep. All rights reserved.
//

import UIKit
import Firebase

class PostRecordVC: UIViewController {
    
    var cameraVC: CameraVC!
    var image: UIImage?
    var storageRef: FIRStorageReference!
    var databaseRef: FIRDatabaseReference!
    var imageData: NSData!
    
    @IBOutlet weak var imageView: UIImageView!
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nil)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.storageRef = FIRStorage.storage().reference()
        self.databaseRef = FIRDatabase.database().reference()
        
        self.imageView.contentMode = UIViewContentMode.ScaleAspectFill
        
        if let validImage2 = self.imageData {
            image = UIImage(data: validImage2)
            self.imageView.image = image
            
        }
        
    }
    

    @IBAction func cancelBtnPressed(sender: AnyObject) {
        cameraVC = CameraVC(nibName: "CameraVC", bundle: nil)
        self.presentViewController(cameraVC, animated: true, completion: nil)
        
    }
    
    @IBAction func postImage(sender: AnyObject) {
        
        let key = databaseRef.child("posts").childByAutoId().key
        
        // Post Data Upload
        let userID = FIRAuth.auth()?.currentUser?.uid
        databaseRef.child("users").child(userID!).observeSingleEventOfType(FIRDataEventType.Value, withBlock: { (snapshot: FIRDataSnapshot) in
            
            let username = snapshot.value!["username"] as! String
            let user = User.init(username: username)
            
            self.postImageInfo(userID!, username: user.username, key: key)
        })
        
        
        // Image upload ++ Make function for image post to database
        let imagePath = FIRAuth.auth()!.currentUser!.uid +
            "/\(key).jpg"
        let data = imageData
        let metadata = FIRStorageMetadata()
        metadata.contentType = "image/jpeg"
        
        self.storageRef.child(imagePath).putData(data, metadata: metadata) { (metadata, error) in
            
            if let error = error {
                print(error)
            } else {
                print("successfullyUploaded")
            }
        
        }
        
    }
    
    func postImageInfo(userID: String, username: String, key: String) {
        
        let storageRef = "gs://current-slate.appspot.com/\(userID)/\(key).jpeg"
        
        let post = ["uid": userID,
                    "username": username,
                    "imageURL": storageRef
                    ]
        
        let childUpdates = ["/posts/\(key)": post,
                            "/user-posts/\(userID)/\(key)/": post]
        
        databaseRef.updateChildValues(childUpdates)
        
        
        
        
    }
    
    
    
    
    
}
