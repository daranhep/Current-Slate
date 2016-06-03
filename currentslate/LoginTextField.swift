//
//  MaterialTextField.swift
//  currentslate
//
//  Created by Dara Nhep on 6/3/16.
//  Copyright © 2016 Dara Nhep. All rights reserved.
//

import UIKit
import Material

class LoginTextField: TextField {

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        MaterialBorder.Border2
        
        self.font = RobotoFont.mediumWithSize(12)
        self.textColor = MaterialColor.white
        self.backgroundColor = MaterialColor.clear
        self.placeholderActiveColor = MaterialColor.white
        self.placeholderColor = MaterialColor.white
        self.dividerColor = MaterialColor.grey.darken4
        
        
        
    }

}
