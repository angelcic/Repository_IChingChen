//
//  SongTableViewCell.swift
//  KKBOXAPIDemo
//
//  Created by iching chen on 2019/8/23.
//  Copyright © 2019 ichingchen. All rights reserved.
//

import UIKit

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
    
    func setupCell(imageUrl: URL, title: String, islike: Bool) {
        
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
    func likeAction(cell: UITableViewCell)
}
