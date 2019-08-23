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
    var songList: [SongData] = []

    var isFetching = false
    
    var favoriteSongList: [IndexPath: Bool] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        adjustTableHeaderView()
        
        let nib = UINib(nibName: "SongTableViewCell", bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: "SongTableViewCell")
        
        fetchNewHits()
        
    }
    
    func fetchNewHits() {
        isFetching = true
        manager.fetchNewHits(){[weak self] result, error in
            self?.isFetching = false
            if result {
                self?.songList = KKBOXAPIManager.manager.songList
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }                
            }
        }

    }
    
    func fetchMoreNewHits() {
        print("====預載更多資料......")
        isFetching = true
        manager.fetchMoreNewHits() {[weak self] result, error in
            self?.isFetching = false
            if result {
                self?.songList = KKBOXAPIManager.manager.songList
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            }
        }
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
        print("點擊了：\(indexPath.row)")
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if isFetching {
            return
        }
        // 滑動 tableView 時預載下一頁資料
        if (indexPath.row > Int(self.songList.count / 10 * 8 )) {
            fetchMoreNewHits()
        }
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
        if songList.count >= indexPath.row {
            cell.setTitle(title: songList[indexPath.row].album.name)
            cell.setImage(imageUrl: songList[indexPath.row].album.images[0].url)
            if let status = favoriteSongList[indexPath] {
                cell.setLikeButton(islike: status)
            } else {
                cell.setLikeButton(islike: false)
            }
            return cell
        } else {
            return cell
        }
    }
    
}

// 喜愛歌曲點擊狀態改變
extension ViewController: SongCellDelegate {
    func likeAction(cell: SongTableViewCell) {
        
        guard let indexPath = tableView.indexPath(for: cell) else { return }
        
        guard
            var status = favoriteSongList[indexPath]
        else {
            favoriteSongList[indexPath] = true
            cell.setLikeButton(islike: true)
            tableView.reloadRows(at: [indexPath], with: .none)
            return
        }
        if status {
            status = false
        } else {
            status = true
        }
        cell.setLikeButton(islike: status)
        tableView.reloadRows(at: [indexPath], with: .none)
    }
    
}
