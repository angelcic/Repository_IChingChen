//
//  SongTableViewCell.swift
//  KKBOXAPIDemo
//
//  Created by iching chen on 2019/8/23.
//  Copyright © 2019 ichingchen. All rights reserved.
//

import UIKit
import Kingfisher

class SongTableViewCell: UITableViewCell {

    @IBOutlet weak var songImageView: UIImageView!
    
    @IBOutlet weak var songTitleLabel: UILabel!
    
    @IBOutlet weak var likeButton: UIButton!
    
    weak var delegate: SongCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        likeButton.addTarget(self, action: #selector(likeAction), for: .touchUpInside)
    }
    
    func setTitle(title: String) {
        songTitleLabel.text = title
    }
    
    func setImage(imageUrl: String) {
        guard let url = URL(string: imageUrl) else {return}
        songImageView.kf.setImage(with: url)
    }
    
    func setLikeButton(islike: Bool) {
        if islike {
            likeButton.setImage(UIImage(named: "icons8-fill-heart-50"), for: .normal)
        } else {
            likeButton.setImage(UIImage(named: "icons8-heart-50"), for: .normal)
        }
    }
    
    func setupCell(imageUrl: URL, title: String, islike: Bool) {
        songImageView.kf.setImage(with: imageUrl)
        songTitleLabel.text = title
        if islike {
            likeButton.setImage(UIImage(named: "icons8-fill-heart-50"), for: .normal)
        } else {
            likeButton.setImage(UIImage(named: "icons8-heart-50"), for: .normal)
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @objc func likeAction() {
        delegate?.likeAction(cell: self)
    }
    
}

protocol SongCellDelegate: AnyObject {
    func likeAction(cell: SongTableViewCell)
}
