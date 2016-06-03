//
//  LoginButton.swift
//  currentslate
//
//  Created by Dara Nhep on 6/3/16.
//  Copyright © 2016 Dara Nhep. All rights reserved.
//

import UIKit
import Material

class LoginButton: FlatButton {

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.backgroundColor = MaterialColor.clear
        self.pulseColor = MaterialColor.amber.accent3
    }

}
