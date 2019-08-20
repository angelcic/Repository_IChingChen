//
//  ViewController.swift
//  SelectionViewDemo
//
//  Created by iching chen on 2019/8/19.
//  Copyright © 2019 ichingchen. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var selectViewOne: SelectionView?
    var selectViewTwo: SelectionView?
    var viewOne = UIView()
    var viewTwo = UIView()
    
    let viewOneBG: [UIColor] = [.red, .yellow]
    let viewTwoBG: [UIColor] = [.red, .yellow, .blue]
    
    let viewOneText = ["Red", "Yellow"]
    let viewTwoText = ["Red", "Yellow", "Blue"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        selectViewOne = SelectionView(CGRect(x: 20, y: 50, width: self.view.frame.width, height: 50))
        selectViewOne?.dataSource = self
        selectViewOne?.delegate = self
        self.view.addSubview(selectViewOne!)
        
        viewOne = UIView(frame: CGRect(x: 20, y: 110, width: self.view.frame.width, height: 100))
        viewOne.backgroundColor = UIColor.red
        self.view.addSubview(viewOne)
        
        selectViewTwo = SelectionView(CGRect(x: 20, y: 300, width: self.view.frame.width, height: 50))
        selectViewTwo?.dataSource = self
        selectViewTwo?.delegate = self
        self.view.addSubview(selectViewTwo!)
        
        viewTwo = UIView(frame: CGRect(x: 20, y: 360, width: self.view.frame.width, height: 100))
        viewTwo.backgroundColor = UIColor.red
        self.view.addSubview(viewTwo)
        
        self.view.backgroundColor = .black
    }
    
}

extension ViewController: SelectionDataSource, SelectionViewDelegate {

    // 那個 button 被點選
    func didSelectAt(_ selectView: SelectionView, index: Int) {
        switch selectView {
        case selectViewOne:
            viewOne.backgroundColor = viewOneBG[index]
        case selectViewTwo:
            viewTwo.backgroundColor = viewTwoBG[index]
        default:
            return
        }
    }
    
    // 決定能不能被點選
    func isEnableBeSelectAt(_ selectView: SelectionView, index: Int) -> Bool {
        if selectView == selectViewTwo && selectViewOne?.currentSelectedIndex == 1 {
            return false
        }
        return true
    }
    
    // 決定 button 數量
    func numberOfSelectBTN(_ selectView: SelectionView) -> Int {
        if selectView == selectViewOne {
            return 2
        } else {
            return 3
        }
    }
    
    // 設定 button 內容
    func buttonForRowAt(_ selectView: SelectionView, index: Int, button: UIButton) {

        switch selectView {
        case selectViewOne :
            button.setTitle(viewOneText[index], for: .normal)

        case selectViewTwo:
            button.setTitle(viewTwoText[index], for: .normal)
        default:
            return
        }
    }
    
    func indicatorColor() -> UIColor {
        return .white
    }
    
}
