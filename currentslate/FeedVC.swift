//
//  FeedVC.swift
//  currentslate
//
//  Created by Dara Nhep on 6/13/16.
//  Copyright © 2016 Dara Nhep. All rights reserved.
//

import UIKit
import DTTableViewManager
import DTModelStorage
import Firebase

class FeedVC: UIViewController, DTTableViewManageable, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        manager.startManagingWithDelegate(self)
        manager.registerCellClass(PostCell)
        
        let foo = ["Custom cell", "Custom cell 2"]
        manager.memoryStorage.addItems(foo)
        
    }


}
