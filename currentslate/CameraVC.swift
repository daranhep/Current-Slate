//
//  CameraVC.swift
//  currentslate
//
//  Created by Dara Nhep on 6/13/16.
//  Copyright © 2016 Dara Nhep. All rights reserved.
//

import UIKit
import CameraManager
import Google_Material_Design_Icons_Swift
import Material

class CameraVC: UIViewController {

    @IBOutlet weak var cameraView: UIView!
    @IBOutlet weak var askForPermissionsBtn: UIButton!
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var cameraBack: UIButton!
    
    let cameraManager = CameraManager()
    
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let recordImage = UIImage(named: "ic_fiber_manual_record_48pt_2x")?.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
        let cameraImage = UIImage(named: "camera_back")?.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
        cameraBack.setImage(cameraImage, forState: .Normal)
        
        recordButton.tintColor = MaterialColor.white
        recordButton.setImage(recordImage, forState: .Normal)
        
        askForPermissionsBtn.hidden = true
        
        cameraManager.showAccessPermissionPopupAutomatically = false
        let currentCameraState = cameraManager.currentCameraStatus()
        
        if currentCameraState == .NotDetermined {
            askForPermissionsBtn.hidden = false
        } else if currentCameraState == .Ready {
            addCameraToView()
        }
        
        prefersStatusBarHidden()
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        cameraManager.resumeCaptureSession()
        print("blah")
        
    }
    
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.cameraManager.stopCaptureSession()
        
    }
    
    private func addCameraToView()
    {
        cameraManager.addPreviewLayerToView(cameraView, newCameraOutputMode: CameraOutputMode.StillImage)
        cameraManager.showErrorBlock = { [weak self] (erTitle: String, erMessage: String) -> Void in
            
            let alertController = UIAlertController(title: erTitle, message: erMessage, preferredStyle: .Alert)
            alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: { (alertAction) -> Void in  }))
            
            self?.presentViewController(alertController, animated: true, completion: nil)
        }
    }
    
    // Camera Functions
    
    
    @IBAction func changeFlashMode(sender: UIButton)
    {
        switch (cameraManager.changeFlashMode()) {
        case .Off:
            sender.setTitle("Flash Off", forState: UIControlState.Normal)
        case .On:
            sender.setTitle("Flash On", forState: UIControlState.Normal)
        case .Auto:
            sender.setTitle("Flash Auto", forState: UIControlState.Normal)
        }
    }


    @IBAction func changeCameraDevice(sender: UIButton) {
        
        if cameraManager.cameraDevice == .Front {
            cameraManager.cameraDevice = .Back
        } else {
            cameraManager.cameraDevice = .Front
        }
    }
    
    
    
    @IBAction func recordButtonTapped(sender: UIButton) {
        
        switch (cameraManager.cameraOutputMode) {
        case .StillImage:
            cameraManager.capturePictureDataWithCompletition({ (imageData, error) in
                var postRecordVC: PostRecordVC!
                postRecordVC = PostRecordVC(nibName: "PostRecordVC", bundle: nil)
                if let capturedImage = imageData {
                    print("The captured image is \(capturedImage.description)")
                    postRecordVC.imageData = capturedImage
                    self.presentViewController(postRecordVC, animated: false, completion: nil)
                }
            })
            
        case .VideoWithMic, .VideoOnly:
            sender.selected = !sender.selected
            sender.setTitle(" ", forState: UIControlState.Selected)
            sender.backgroundColor = sender.selected ? UIColor.redColor() : UIColor.greenColor()
            if sender.selected {
                cameraManager.startRecordingVideo()
            } else {
                cameraManager.stopRecordingVideo({ (videoURL, error) -> Void in
                    var postVideoRecordVC: PostVideoRecordVC!
                    postVideoRecordVC = PostVideoRecordVC(nibName: "PostVideoRecordVC", bundle: nil)
                    if let capturedVideo = videoURL {
                        postVideoRecordVC.url = capturedVideo
                        self.presentViewController(postVideoRecordVC, animated: false, completion: nil)
                    }
                    if let errorOccured = error {
                        self.cameraManager.showErrorBlock(erTitle: "Error occurred", erMessage: errorOccured.localizedDescription)
                    }
                })
            }
        }
    }
    
    

    @IBAction func tapped(sender: UITapGestureRecognizer) {
        
        cameraManager.capturePictureDataWithCompletition({ (imageData, error) in
            let vc: PostRecordVC? = self.storyboard?.instantiateViewControllerWithIdentifier("PostRecordVC") as? PostRecordVC
            if let validVC: PostRecordVC = vc {
                if let capturedImage = imageData {
                    validVC.imageData = capturedImage
                    self.presentViewController(validVC, animated: false, completion: nil)
                }
            }
            
        })
        
        print("this was tapped")
        
    }

    @IBAction func tappedLong(sender: UILongPressGestureRecognizer) {
        
        
        
    }
    @IBAction func askForPermission(sender: AnyObject) {
        
        cameraManager.askUserForCameraPermissions ({ permissionGranted in
            self.askForPermissionsBtn.hidden = true
            if permissionGranted {
                self.addCameraToView()
            }
        })
    }
    
}
