//
//  SignInOptionsVC.swift
//  currentslate
//
//  Created by Dara Nhep on 6/3/16.
//  Copyright © 2016 Dara Nhep. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import FirebaseAuth

class RegisterOptionsVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func fbLoginBtnPushed(sender: AnyObject) {
        
        let faceboookLogin = FBSDKLoginManager()
        
        faceboookLogin.logInWithReadPermissions(["email"], fromViewController: self) { (facebookResult, facebookError) in
            if facebookError != nil {
                
                print("Facebook login failed. Error \(facebookError)")
                
            } else if facebookResult.isCancelled {
                
                print("Facebook login was cancelled")
                
            } else {
                
                print("you are in")
                
                let credential = FIRFacebookAuthProvider.credentialWithAccessToken(FBSDKAccessToken.currentAccessToken().tokenString)
                FIRAuth.auth()?.signInWithCredential(credential, completion: { (user, error) in
                    
                    if let error = error {
                        print("There was a problem authenticating \(error)")
                    } else {
                        
                        print("you have authenticated with facebook \(user)")
                    }
                    
                    
                })
                
            }
        }

        
    }


}
