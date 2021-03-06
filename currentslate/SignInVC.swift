//
//  ViewController.swift
//  currentslate
//
//  Created by Dara Nhep on 6/2/16.
//  Copyright © 2016 Dara Nhep. All rights reserved.
//

import UIKit
import Firebase
import FBSDKLoginKit
import FirebaseDatabase
import FirebaseStorage

class SignInVC: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    var ref: FIRDatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.hideKeyboardWhenTappedAround()
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        if FIRAuth.auth()?.currentUser != nil {
            performSegueWithIdentifier("SignedIn", sender: nil)
        }
        
        ref = FIRDatabase.database().reference()
        
    }

    
    @IBAction func loginBtnPressed(sender: AnyObject) {
        
        if let email = emailTextField.text where email != "", let pwd = passwordTextField.text where pwd != "" {
            
            FIRAuth.auth()?.signInWithEmail(email, password: pwd, completion: { (user, error) in
                if let error = error {
                    
                    print(error)
                    
                    if error.code == ERROR_USER_NOT_FOUND {
                        self.showErrorAlert("Email account does not exist", msg: "Please enter a valid email")
                    }
                    
                    if error.code == ERROR_INVALID_EMAIL {
                        self.showErrorAlert("Please enter a valid email address", msg: "Thanks")
                    }
                    
                } else {
                    print("You are in")
                    if let user = FIRAuth.auth()?.currentUser {
                        self.signedIn(user)
                    }
                }
            })
            
        } else {
            self.showErrorAlert("Email and Password Required", msg: "You must enter an email and password")
        }
        
    }
    
    @IBAction func fbLoginBtnPressed(sender: AnyObject) {
        
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
                        if let user = FIRAuth.auth()?.currentUser {
                            self.signedIn(user)
                        }
                    }
                    
                    
                })
                
            }
        }
    }
    
    func signedIn (user: FIRUser){
        performSegueWithIdentifier("SignedIn", sender: nil)
    }
    
    
    func showErrorAlert(title: String, msg: String) {
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .Alert)
        let action = UIAlertAction(title: "Ok", style: .Default, handler: nil)
        alert.addAction(action)
        presentViewController(alert, animated: true, completion: nil)
    }
    
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if textField.nextField != nil {
            textField.nextField?.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
        
        return true
    }



}

