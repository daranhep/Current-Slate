//
//  LoginView.swift
//  currentslate
//
//  Created by Dara Nhep on 6/10/16.
//  Copyright © 2016 Dara Nhep. All rights reserved.
//

import UIKit
import Material

class LoginView: UIView {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let topColor = UIColor(red: (15/255.0), green: (118/255.0), blue: 128/255.0, alpha: 1)
        let bottomColor = UIColor(red: (84/255.0), green: (187/255.0), blue: (187/255.0), alpha: 1)
        
        let gradientColors: [CGColor] = [topColor.CGColor, bottomColor.CGColor]
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = gradientColors
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
        
        gradientLayer.frame = self.frame
        self.layer.insertSublayer(gradientLayer, atIndex: 0)
    }
    
}
