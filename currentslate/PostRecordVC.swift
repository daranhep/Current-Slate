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
    var imageData: NSData?
    
    @IBOutlet weak var imageView: UIImageView!
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nil)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        storageRef = FIRStorage.storage().reference()
        
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
    
//    @IBAction func postImage(sender: AnyObject) {
//        
//        
//        
//    }
}
