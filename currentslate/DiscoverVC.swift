//
//  DiscoverVC.swift
//  currentslate
//
//  Created by Dara Nhep on 6/13/16.
//  Copyright © 2016 Dara Nhep. All rights reserved.
//

import UIKit
import Firebase

class DiscoverVC: UIViewController {
    
    var storyBoard: UIStoryboard?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setNeedsStatusBarAppearanceUpdate()
        // Do any additional setup after loading the view.
    }


    @IBAction func signOut(sender: AnyObject) {
        try! FIRAuth.auth()!.signOut()
        print("You have signed out")
        storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyBoard?.instantiateViewControllerWithIdentifier("SignedInMain")
        self.presentViewController(vc!, animated: true, completion: nil)
        
    }
    

}
