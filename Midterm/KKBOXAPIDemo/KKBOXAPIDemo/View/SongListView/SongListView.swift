//
//  SongListView.swift
//  KKBOXAPIDemo
//
//  Created by iching chen on 2019/8/23.
//  Copyright © 2019 ichingchen. All rights reserved.
//

import UIKit

protocol SongListViewDelegate: UITableViewDataSource, UITableViewDelegate, SongCellDelegate, AnyObject {
    func likeAction(cell: SongTableViewCell)
}

class SongListView: UIView {
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.delegate = self.delegate
            tableView.dataSource =  self.delegate
        }
    }
    
    weak var delegate: SongListViewDelegate? {
        
        didSet {
            
            guard let tableView = tableView else { return }
            
            tableView.dataSource = self.delegate
            
            tableView.delegate = self.delegate
        }
    }
    
    @IBOutlet weak var headerImageView: UIImageView!

    override func awakeFromNib() {
        setupTableView()
    }
    
    func reloadData() {
//        tableView.reloadData()
        tableView.reloadDataSmoothly()
    }

    func setupTableView() {
        adjustTableHeaderView()
        
        let nib = UINib(nibName: "SongTableViewCell", bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: "SongTableViewCell")
        
    }
    
    // tableHeaderView 加入 image
    func adjustTableHeaderView() {
        headerImageView.image = UIImage(named: "600x600")
        let screenWidth = UIScreen.main.bounds.width
        headerImageView.frame.size = CGSize(width: screenWidth, height: screenWidth)
        headerImageView.clipsToBounds = true
        headerImageView.contentMode = UIView.ContentMode.scaleAspectFill
    }
}


