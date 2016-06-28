//
//  MainVC.swift
//  currentslate
//
//  Created by Dara Nhep on 6/13/16.
//  Copyright © 2016 Dara Nhep. All rights reserved.
//

import UIKit

class MainVC: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var scrollView: UIScrollView!
    
    let cameraVC = CameraVC()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let cameraVC : CameraVC = CameraVC(nibName: "CameraVC", bundle: nil)
        let feedVC : FeedVC = FeedVC(nibName: "FeedVC", bundle: nil)
        let discoverVC : DiscoverVC = DiscoverVC(nibName: "DiscoverVC", bundle: nil)
        
        
        //Adding Child View Controllers
        
        self.addChildViewController(feedVC)
        self.scrollView.addSubview(feedVC.view)
        feedVC.didMoveToParentViewController(self)
        
        self.addChildViewController(cameraVC)
        self.scrollView.addSubview(cameraVC.view)
        cameraVC.didMoveToParentViewController(self)
        
        self.addChildViewController(discoverVC)
        self.scrollView.addSubview(discoverVC.view)
        discoverVC.didMoveToParentViewController(self)
        
        
        
        //Setting up the frame
        var cameraVCFrame : CGRect = cameraVC.view.frame
        cameraVCFrame.origin.x = self.view.frame.width
        cameraVC.view.frame = cameraVCFrame
        
        var discoverVCFrame : CGRect = discoverVC.view.frame
        discoverVCFrame.origin.x =  2 *  self.view.frame.width
        discoverVC.view.frame = discoverVCFrame

        self.scrollView.contentSize = CGSizeMake(self.view.frame.width * 3, self.view.frame.size.height)
        
    }
    
   }
