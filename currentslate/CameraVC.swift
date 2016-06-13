//
//  CameraVC.swift
//  currentslate
//
//  Created by Dara Nhep on 6/13/16.
//  Copyright © 2016 Dara Nhep. All rights reserved.
//

import UIKit
import CameraManager

class CameraVC: UIViewController {

    @IBOutlet weak var cameraView: UIView!
    @IBOutlet weak var askForPermissionsBtn: UIButton!
    
    let cameraManager = CameraManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        askForPermissionsBtn.hidden = true
        
        cameraManager.showAccessPermissionPopupAutomatically = false
        let currentCameraState = cameraManager.currentCameraStatus()
        
        if currentCameraState == .NotDetermined {
            askForPermissionsBtn.hidden = false
        } else if currentCameraState == .Ready {
            addCameraToView()
        }
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        cameraManager.resumeCaptureSession()
        
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        cameraManager.stopCaptureSession()
        
    }
    
    
    private func addCameraToView()
    {
        cameraManager.addPreviewLayerToView(cameraView, newCameraOutputMode: CameraOutputMode.VideoWithMic)
        cameraManager.showErrorBlock = { [weak self] (erTitle: String, erMessage: String) -> Void in
            
            let alertController = UIAlertController(title: erTitle, message: erMessage, preferredStyle: .Alert)
            alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: { (alertAction) -> Void in  }))
            
            self?.presentViewController(alertController, animated: true, completion: nil)
        }
    }

    @IBAction func changeCameraDevice(sender: AnyObject) {
        
        cameraManager.cameraDevice = cameraManager.cameraDevice == CameraDevice.Front ? CameraDevice.Back : CameraDevice.Front
        switch (cameraManager.cameraDevice) {
        case .Front:
            sender.setTitle("Front", forState: UIControlState.Normal)
        case .Back:
            sender.setTitle("Back", forState: UIControlState.Normal)
        }

        
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
