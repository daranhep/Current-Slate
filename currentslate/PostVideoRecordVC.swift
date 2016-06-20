//
//  PostVideoRecordVC.swift
//  currentslate
//
//  Created by Dara Nhep on 6/20/16.
//  Copyright © 2016 Dara Nhep. All rights reserved.
//

import UIKit
import AVFoundation

class PostVideoRecordVC: UIViewController {

    @IBOutlet weak var videoView: UIView!
    var avPlayer: AVPlayer!
    var url: NSURL!
    var screenRect: CGRect!
    var avPlayerLayer: AVPlayerLayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        self.avPlayer = AVPlayer(URL: url)
//        self.avPlayerLayer = AVPlayerLayer(player: self.avPlayer)
//        self.avPlayerLayer.videoGravity = AVLayerVideoGravityResizeAspectFill
//        self.videoView.layer.addSublayer(avPlayerLayer)
//        self.avPlayerLayer.frame = self.videoView.bounds
    }
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        
        
    }
    
    override func viewDidLayoutSubviews() {
        
        super.viewDidLayoutSubviews()
        
        self.avPlayer = AVPlayer(URL: url)
        self.avPlayerLayer = AVPlayerLayer(player: self.avPlayer)
        self.avPlayerLayer.videoGravity = AVLayerVideoGravityResizeAspectFill
        self.videoView.layer.addSublayer(avPlayerLayer)
        self.avPlayerLayer.frame = self.videoView.bounds
        self.avPlayer.play()
    }
    
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
}
