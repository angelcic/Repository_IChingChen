//
//  AddPage.swift
//  PaseValueDemo
//
//  Created by iching chen on 2019/8/20.
//  Copyright © 2019 ichingchen. All rights reserved.
//

import Foundation
import  UIKit

class  AddCellPage: UIViewController {
    
    var modifyTextField: UITextField!
    var confirmButton: UIButton!
    
    var currentIndex: Int?
    var currentText: String?
    
    var callback: ((Int?, String?) -> Void)?
    
    var delegate: AddCellPageDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        setupUI()
    }
    
    func setupUI() {
        
        modifyTextField = UITextField(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        modifyTextField.borderStyle = .roundedRect
        modifyTextField.text = currentText
        
        confirmButton = UIButton(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        
        confirmButton.backgroundColor = .black
        confirmButton.setTitle("Button", for: .normal)
        confirmButton.setTitleColor(.white, for: .normal)
        confirmButton.addBorder(borderColor: .white, borderWidth: 1, cornerRadius: 10)
        
        confirmButton.addTarget(self, action: #selector(confirmAction), for: .touchUpInside)
        
        self.view.addSubview(modifyTextField)
        self.view.addSubview(confirmButton)
        
        modifyTextField.translatesAutoresizingMaskIntoConstraints = false
        confirmButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            modifyTextField.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 100),
            modifyTextField.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            modifyTextField.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 2/3),
            modifyTextField.heightAnchor.constraint(equalToConstant: 40),
            
            confirmButton.topAnchor.constraint(equalTo: self.view.centerYAnchor, constant: 20),
            confirmButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            confirmButton.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 2/3),
            confirmButton.heightAnchor.constraint(equalToConstant: 40),
        ])
    }
    
    @objc func confirmAction() {
        let text = modifyTextField.text
        
        delegate?.finish(index: currentIndex, text: text)
        
//        callback?(currentIndex, text)
        
        navigationController?.popToRootViewController(animated: false)
    }

}

protocol AddCellPageDelegate {
    func finish(index: Int?, text: String?)
}
