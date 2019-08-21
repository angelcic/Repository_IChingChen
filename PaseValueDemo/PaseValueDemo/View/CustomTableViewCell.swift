//
//  CustomTableViewCell.swift
//  PaseValueDemo
//
//  Created by iching chen on 2019/8/20.
//  Copyright © 2019 ichingchen. All rights reserved.
//

import Foundation
import UIKit

// 從 storyboard 拉的 tableViewCell 後來沒用到
class CustomTableViewCell: UITableViewCell {
    
    @IBOutlet weak var deleteButton: UIButton!
    
    
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        deleteButton.setTitle("delete", for: .normal)
        deleteButton.setTitleColor(.purple, for: .normal)
                
        deleteButton.addBorder(borderColor: .purple, borderWidth: 1, cornerRadius: 10)
    }
}
