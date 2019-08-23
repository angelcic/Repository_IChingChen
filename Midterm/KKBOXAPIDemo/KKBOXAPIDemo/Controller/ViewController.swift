//
//  ViewController.swift
//  KKBOXAPIDemo
//
//  Created by iching chen on 2019/8/23.
//  Copyright © 2019 ichingchen. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.delegate = self
            tableView.dataSource =  self
        }
    }
    
    @IBOutlet weak var headerImageView: UIImageView!
    
    let manager = KKBOXAPIManager.manager
    
    var isLike: [IndexPath: Bool] = [:]    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        adjustTableHeaderView()
        
        let nib = UINib(nibName: "SongTableViewCell", bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: "SongTableViewCell")
        
        fetchNewHits()
    }
    
    func fetchNewHits() {
        manager.fetchNewHits(){[weak self] result, error in
            if result {
                self?.tableView.reloadData()
            }
        }

    }
    
    func fetchMoreNewHits() {
        
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

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return manager.songList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(withIdentifier: "SongTableViewCell", for: indexPath) as? SongTableViewCell
        else {
            return UITableViewCell()
        }
        
        cell.delegate = self
        // TODO:
        
        
        return cell
    }
    
}

extension ViewController: SongCellDelegate {
    func likeAction(cell: UITableViewCell) {
        guard let index = tableView.indexPath(for: cell) else { return }
        // TODO:
    }
    
}
