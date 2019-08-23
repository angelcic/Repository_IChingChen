//
//  ViewController.swift
//  PaseValueDemo
//
//  Created by iching chen on 2019/8/20.
//  Copyright © 2019 ichingchen. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var context = ["2", "3", "4", "5"]

    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        self.navigationItem.rightBarButtonItem?.target = self
        self.navigationItem.rightBarButtonItem?.action = #selector(nextPage)
     
    }

    @objc func nextPage() {
        showNextVC(index: nil, text: "")
    }
    
    func deleteCell(index: Int) {
        
        context.remove(at: index)
        tableView.reloadData()
    }
    
    func showNextVC(index: Int?, text: String) {
        let nextVC = AddCellPage()
        nextVC.delegate = self
        nextVC.currentIndex = index
        nextVC.currentText = text
        nextVC.callback = {[weak self] index, text in
            self?.addOrModifyCell(index, text)
        }
        show(nextVC, sender: nil)
    }
    
    func addOrModifyCell(_ index: Int?, _ text: String?) {
        if let index = index {
            context[index] = text ?? ""
            tableView.reloadRows(at: [IndexPath(row: index, section: 0)], with: .none)
        } else {
            context.append(text ?? "")
            tableView.reloadData()
        }
    }
}

extension ViewController: AddCellPageDelegate {
    func finish(index: Int?, text: String?) {
        addOrModifyCell(index, text)
    }
}

extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard
            let cell = tableView.cellForRow(at: indexPath) as? MyTableViewCell,
            let text = cell.titleLabel.text
        else { return }
        
        showNextVC(index: indexPath.row, text: text)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return context.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = "mainCell"
        let cell = MyTableViewCell(style: UITableViewCell.CellStyle.subtitle, reuseIdentifier: identifier)
        
        cell.titleLabel?.text = context[indexPath.row]
        cell.deletedButton.tag = indexPath.row
        
        // 用 delegate
        cell.delegate = self
        
        // 用 closure
//        cell.callback = {[weak self] index in
//            self?.deleteCell(index: index)
//        }
        
        // 用 addTarget 傳值
//        cell.deletedButton.addTarget(self, action: #selector(deleteAction), for: .touchUpInside)
        
        return cell
        
    }
    
    @objc func deleteAction(_ sender: UIButton) {
       
        deleteCell(index: sender.tag)
    }
    
}

extension ViewController: ActionHandler {
    func remove(index: Int) {
        deleteCell(index: index)
    }
}
