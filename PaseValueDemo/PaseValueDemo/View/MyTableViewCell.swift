//
//  MyTableViewCell.swift
//  PaseValueDemo
//
//  Created by iching chen on 2019/8/20.
//  Copyright © 2019 ichingchen. All rights reserved.
//

import UIKit

class MyTableViewCell: UITableViewCell {
    
    var titleLabel: UILabel!
    var deletedButton: UIButton!
    
    var delegate: ActionHandler? //
    var callback: ((Int) -> Void)?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    func setupUI() {
        self.selectionStyle = .none
        
        titleLabel = UILabel(frame: CGRect())
        deletedButton = UIButton(frame: CGRect())
        deletedButton.setTitle("delete", for: .normal)
        deletedButton.setTitleColor(.purple, for: .normal)
        
        deletedButton.addBorder(borderColor: .purple, borderWidth: 1, cornerRadius: 10)
        
        deletedButton.addTarget(self, action: #selector(didTouchAction(sender:)), for: .touchUpInside)
        
        self.addSubview(titleLabel)
        self.addSubview(deletedButton)
        
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        deletedButton.translatesAutoresizingMaskIntoConstraints = false
        
//        setConstraints(titleLabel)
//        setConstraints(deletedButton)
        titleLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20).isActive = true
        titleLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        titleLabel.rightAnchor.constraint(greaterThanOrEqualTo: deletedButton.leftAnchor, constant: -16).isActive = true
        deletedButton.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -16).isActive = true
        deletedButton.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        deletedButton.widthAnchor.constraint(equalToConstant: 60).isActive = true
        
    }
   
    func setConstraints(_ view: UIView) {
        view.translatesAutoresizingMaskIntoConstraints = false
        let leftConstraints = NSLayoutConstraint(item: view, attribute: .left, relatedBy: .equal, toItem: self, attribute: .left, multiplier: 1, constant: 16)
        
        let rightConstraints = NSLayoutConstraint(item: view, attribute: .right, relatedBy: .equal, toItem: self.contentView, attribute: .right, multiplier: 1, constant: -16)
        
        let heightConstraints = NSLayoutConstraint(item: view, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1, constant: 40)
        
        self.addConstraints([leftConstraints, rightConstraints, heightConstraints])
    }
    
    @objc func didTouchAction(sender: UIButton) {
        delegate?.remove(index: sender.tag)
        callback?(sender.tag)
    }

}

protocol ActionHandler {
    func remove(index: Int)
    
}
