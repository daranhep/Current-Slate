//
//  PostRecordVC.swift
//  currentslate
//
//  Created by Dara Nhep on 6/16/16.
//  Copyright © 2016 Dara Nhep. All rights reserved.
//

import UIKit

class PostRecordVC: UIViewController {
    
    var cameraVC: CameraVC!
    var image: UIImage?
    
    @IBOutlet weak var imageView: UIImageView!
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        if let validImage = self.image {
            self.imageView.image = validImage
        }
    }
    

    @IBAction func cancelBtnPressed(sender: AnyObject) {
        cameraVC = CameraVC(nibName: "CameraVC", bundle: nil)
        self.presentViewController(cameraVC, animated: true, completion: nil)
        
    }
    
}
