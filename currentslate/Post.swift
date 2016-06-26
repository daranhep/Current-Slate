//
//  Post.swift
//  currentslate
//
//  Created by Dara Nhep on 6/24/16.
//  Copyright © 2016 Dara Nhep. All rights reserved.
//

import Foundation

class Post {
    
    private var _imageURL: String!
    private var _uid: String!
    private var _username: String!
    private var _postKey: String?
    
    var imageURL: String {
        return _imageURL
    }
    
    var uid: String {
        return _uid
    }
    
    var username: String {
        return _username
    }
    
    init(uid: String, username: String, imageURL: String) {
        self._uid = uid
        self._imageURL = imageURL
        self._uid = uid
    }
    
    init(postKey: String, dictionary: Dictionary<String, AnyObject>) {
        self._postKey = postKey
        
        if let imageURL = dictionary["imageURL"] as? String {
            self._imageURL = imageURL
        }
        
        if let username = dictionary["username"] as? String {
            self._username = username
        }
        
        if let uid = dictionary["uid"] as? String {
            self._uid = uid
        }
    }
    
}