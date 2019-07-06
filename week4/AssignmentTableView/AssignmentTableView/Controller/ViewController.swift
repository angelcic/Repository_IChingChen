//
//  ViewController.swift
//  AssignmentTableView
//
//  Created by iching chen on 2019/7/5.
//  Copyright © 2019 ichingchen. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    let dataSource = TableViewDataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = dataSource
    }

    
    
    
}

