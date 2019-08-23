//
//  UITableViewExtension.swift
//  KKBOXAPIDemo
//
//  Created by iching chen on 2019/8/23.
//  Copyright © 2019 ichingchen. All rights reserved.
//

import Foundation
import  UIKit

extension UITableView {
    func reloadDataSmoothly() {
        UIView.setAnimationsEnabled(false)
        CATransaction.begin()
        
        CATransaction.setCompletionBlock { () -> Void in
            UIView.setAnimationsEnabled(true)
        }
        
        reloadData()
        beginUpdates()
        endUpdates()
        
        CATransaction.commit()
    }
}
