//
//  RegisterVC.swift
//  currentslate
//
//  Created by Dara Nhep on 6/3/16.
//  Copyright © 2016 Dara Nhep. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import FirebaseStorage

class RegisterVC: UIViewController {

    @IBOutlet weak var emailTextField: LoginTextField!
    @IBOutlet weak var usernameTextField: LoginTextField!
    @IBOutlet weak var pwdTextField: LoginTextField!
    var ref: FIRDatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.hideKeyboardWhenTappedAround()
        
        ref = FIRDatabase.database().reference()
        
        }

    
    @IBAction func nextBtnPressed(sender: AnyObject) {
        
        if let email = emailTextField.text where email != "", let pwd = pwdTextField.text where pwd != "", let username = usernameTextField.text where username != ""  {
            
            FIRAuth.auth()?.createUserWithEmail(email, password: pwd, completion: { (user, error) in
                
                if let error = error {
                    
                    print(error)
                    if error.code == ERROR_EMAIL_ALREADY_IN_USE {
                        self.showErrorAlert("Email already in use", msg: "Please choose a different email")
                    }
                    if error.code == ERROR_INVALID_EMAIL {
                        self.showErrorAlert("Invalid Email", msg: "Please enter a valid email")
                    }
                    
                } else {
                    print("User created and You are logged in")
                    let changeRequest = FIRAuth.auth()?.currentUser?.profileChangeRequest()
                    changeRequest?.displayName = username
                    changeRequest?.commitChangesWithCompletion({ (error) in
                        if let error = error {
                            print(error.localizedDescription)
                        } else {
                            self.ref.child("users").child(user!.uid).setValue(["username": username])
                            self.performSegueWithIdentifier("SignedInFromReg", sender: nil)
                        }
                    })
                }
            })
        } else {
            showErrorAlert("Required Field", msg: "Please enter all the required fields")
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
}