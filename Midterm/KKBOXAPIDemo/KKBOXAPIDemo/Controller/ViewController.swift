//
//  ViewController.swift
//  KKBOXAPIDemo
//
//  Created by iching chen on 2019/8/23.
//  Copyright © 2019 ichingchen. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var songListView: SongListView! {
        didSet {
            songListView.delegate = self
        }
    }
    
    let manager = KKBOXAPIManager.manager
    var songList: [SongData] = []

    var isFetching = false // 是否正在下載資料
    var noMorePage = false // 是否已經沒有更多資料
    
    // 記錄使用者點擊喜歡按鈕
    var favoriteSongList: [IndexPath: Bool] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchNewHits()
    }
    
    // 第一次下載資料
    func fetchNewHits() {
        isFetching = true
        manager.fetchNewHits(){[weak self] result, error in
            self?.isFetching = false
            if result {
                self?.songList = KKBOXAPIManager.manager.songList
                DispatchQueue.main.async {
                    self?.songListView.reloadData()
                }                
            }
        }

    }
    
    // 下載下一頁的資料
    func fetchMoreNewHits() {
        isFetching = true
        manager.fetchMoreNewHits() {[weak self] result, error in
            self?.isFetching = false
            if result {
                self?.songList = KKBOXAPIManager.manager.songList
                DispatchQueue.main.async {
                    self?.songListView.reloadData()
                }
            } else {
                print(error ?? "failed")
                guard let error = error as? KKBOXAPIManager.FetchError else {return}
                if error == KKBOXAPIManager.FetchError.noMorePage {
                    self?.noMorePage = true
                }
            }
        }
    }
    
}

extension ViewController: SongListViewDelegate {
    
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("點擊了：\(indexPath.row)")
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        if isFetching || noMorePage {
            return
        }
        // 滑動 tableView 時若達目前可顯示筆數的 80% 預載下一頁資料
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

        guard let indexPath = songListView.tableView.indexPath(for: cell) else { return }

        guard
            var status = favoriteSongList[indexPath]
        else {
            favoriteSongList[indexPath] = true
            cell.setLikeButton(islike: true)
            songListView.tableView.reloadRows(at: [indexPath], with: .none)
            return
        }
        if status {
            status = false
        } else {
            status = true
        }
        cell.setLikeButton(islike: status)
        songListView.tableView.reloadRows(at: [indexPath], with: .none)
    }

}
