//
//  ViewController.swift
//  MemoryLeakDemo
//
//  Created by iching chen on 2019/8/21.
//  Copyright © 2019 ichingchen. All rights reserved.
//

import UIKit

class ViewController: UIViewController, SendDataDelegate {
    
    var nextPageButton = UIButton()
    var closureBTN = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nextPageButton.backgroundColor = .orange
        nextPageButton.setTitle("Delegate Demo", for: .normal)
        nextPageButton.addTarget(self, action: #selector(goToNextPage), for: .touchUpInside)
        
        self.view.addSubview(nextPageButton)
        
        nextPageButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            nextPageButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            nextPageButton.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            nextPageButton.widthAnchor.constraint(equalToConstant: 200),
            nextPageButton.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        closureBTN.backgroundColor = .purple
        closureBTN.setTitle("Closure Demo", for: .normal)
        closureBTN.addTarget(self, action: #selector(goToNextPage2), for: .touchUpInside)
        
        self.view.addSubview(closureBTN)
        
        closureBTN.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            closureBTN.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            closureBTN.topAnchor.constraint(equalTo: nextPageButton.centerYAnchor, constant: 60),
            closureBTN.widthAnchor.constraint(equalToConstant: 200),
            closureBTN.heightAnchor.constraint(equalToConstant: 50)
            ])
        
    }
    
    deinit {
        print("VC1 died")
    }
    
    @objc func  goToNextPage() {
        let VC = DelegateVC()
        show(VC, sender: nil)
    }
    
    @objc func  goToNextPage2() {
        let VC = ClosureVC()
        show(VC, sender: nil)
    }
}


