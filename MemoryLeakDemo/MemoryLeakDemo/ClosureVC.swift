//
//  ClosureVC.swift
//  MemoryLeakDemo
//
//  Created by iching chen on 2019/8/21.
//  Copyright © 2019 ichingchen. All rights reserved.
//

import Foundation
import UIKit

class ClosureVC: UIViewController{
    
    var closureDemoView: ClosureDemoView!
    var blabla = 2
    
    func callbackFunction(){}
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        closureDemoView = ClosureDemoView()
//        closureDemoView.callback = {[weak self] in
//            self?.blabla += 2
//        }
        
//        weak var weakself = self
        
//         closureDemoView.callback = callbackFunction // 這樣寫會造成 reference recycle，因為要找到 callbackFunction 其實還是要先找到持有他的人(self)才叫得到 callbackFunction，但 strong self 就會造成 reference recycle
        closureDemoView.callback = { [weak self] in
            self?.callbackFunction()
        }
        
    }
    
    deinit {
        print("I, closureDemoView, am well gone, bruh")
    }
}

class ClosureDemoView {
    var callback: (() -> ())?
}
