//
//  Post.swift
//  currentslate
//
//  Created by Dara Nhep on 6/24/16.
//  Copyright © 2016 Dara Nhep. All rights reserved.
//

import Foundation

class Post {
    
    var uid: String?
    var imageUrl: String?
    
    init(uid: String, username: String, imageUrl: String) {
        self.uid = uid
        self.imageUrl = imageUrl
    }
    
}