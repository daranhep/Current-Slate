//
//  PostCell.swift
//  currentslate
//
//  Created by Dara Nhep on 6/21/16.
//  Copyright © 2016 Dara Nhep. All rights reserved.
//

import UIKit
import DTTableViewManager
import DTModelStorage

class PostCell: UITableViewCell, ModelTransfer {
    
    @IBOutlet weak var label: UILabel!
    func updateWithModel(model: Post) {
        
        self.label.text = model.username
    }
    
}
