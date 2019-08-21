//
//  ExtensionUIView.swift
//  PaseValueDemo
//
//  Created by iching chen on 2019/8/21.
//  Copyright © 2019 ichingchen. All rights reserved.
//

import Foundation
import  UIKit

extension UIView {
    func addBorder(borderColor: UIColor, borderWidth: CGFloat, cornerRadius: CGFloat) {
        self.layer.borderWidth = borderWidth
        self.layer.borderColor = borderColor.cgColor
        self.layer.cornerRadius = cornerRadius
        self.clipsToBounds = true
    }
}
