//
//  TableViewDataSource.swift
//  AssignmentTableView
//
//  Created by iching chen on 2019/7/5.
//  Copyright © 2019 ichingchen. All rights reserved.
//

import Foundation
import UIKit

class TableViewDataSource: NSObject, UITableViewDataSource {
    // 群組數量
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    // 行數
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    // 設定 cell 內容
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "tableViewCell", for: indexPath) as? TableViewCell else {
            return UITableViewCell()
        }
        
        cell.rowDataLabel.text = "This is section \(indexPath.section), row \(indexPath.row)"
        
        tableView.rowHeight = 130
        
        return cell
    }
}
