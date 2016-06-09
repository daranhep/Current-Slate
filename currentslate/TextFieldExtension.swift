//
//  TextFieldExtension.swift
//  currentslate
//
//  Created by Dara Nhep on 6/9/16.
//  Copyright © 2016 Dara Nhep. All rights reserved.
//

import Foundation
import UIKit

private var kAssociationKeyNextField: UInt8 = 0

extension UITextField {
    @IBOutlet var nextField: UITextField? {
        
        get {
            return objc_getAssociatedObject(self, &kAssociationKeyNextField) as? UITextField
        }
        set(newField) {
            objc_setAssociatedObject(self, &kAssociationKeyNextField, newField, .OBJC_ASSOCIATION_RETAIN)
        }
    }
    

}