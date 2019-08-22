//
//  ReceivingVC.swift
//  MemoryLeakDemo
//
//  Created by iching chen on 2019/8/21.
//  Copyright © 2019 ichingchen. All rights reserved.
//

import Foundation
import UIKit

class DelegateVC: UIViewController, SendDataDelegate {
    
    var demoView: DemoView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        
        demoView = DemoView()
        demoView.delegate = self
    }
    
    deinit {
        demoView = nil
        print("I'm well gone, bruh")
    }
}

class DemoView {
    var delegate: SendDataDelegate?
    
    deinit {
        print("I, demoView, am well gone, bruh")
    }
}

protocol SendDataDelegate: class {
    
}

