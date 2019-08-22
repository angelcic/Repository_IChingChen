//
//  ViewController.swift
//  GCDDemo
//
//  Created by iching chen on 2019/8/22.
//  Copyright © 2019 ichingchen. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var firstRoadLabel: UILabel!
    @IBOutlet weak var firstSpeedLabel: UILabel!
    
    @IBOutlet weak var secondRoadLabel: UILabel!
    @IBOutlet weak var secondSpeedLabel: UILabel!    
    
    @IBOutlet weak var thirdRoadLabel: UILabel!
    @IBOutlet weak var thirdSpeedLabel: UILabel!
    
    var firstSpeedMeasureView: SpeedMeasureView!
    var apiManager = APIManager.manager
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addButton()
        
    }
    
    let groupButton = UIButton()
    let semaphoreButton = UIButton()
    
    func addButton() {
        groupButton.backgroundColor = .white
        groupButton.setTitle("GCD Group", for: .normal)
        groupButton.setTitleColor(.darkGray, for: .normal)
        groupButton.addTarget(self, action: #selector(group), for: .touchUpInside)
        semaphoreButton.backgroundColor = .white
        semaphoreButton.setTitle("GCD Semaphore", for: .normal)
        semaphoreButton.setTitleColor(.darkGray, for: .normal)
        semaphoreButton.addTarget(self, action: #selector(semaphore), for: .touchUpInside)

        self.view.addSubview(groupButton)
        self.view.addSubview(semaphoreButton)
        groupButton.translatesAutoresizingMaskIntoConstraints = false
        semaphoreButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            groupButton.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 70),
            groupButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 50),
            groupButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -50),
            semaphoreButton.topAnchor.constraint(equalTo: groupButton.bottomAnchor, constant: 20),
            semaphoreButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 50),
            semaphoreButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -50),
        ])
    }
    
    @objc func group() {
        defaultString()
        print("======group======")
        let task1 = DispatchQueue(label: "getFirstSpeedMasureInfo")
        let task2 = DispatchQueue(label: "getSecondSpeedMasureInfo")
        let task3 = DispatchQueue(label: "getThirdSpeedMasureInfo")
        let group = DispatchGroup()
        
        group.enter()
        print("1 start")
        task1.async(group: group, qos: .default) { [weak self] in
            self?.apiManager.getSpeedMasureInfo(offset: 0) {_,_,_ in
                print("1 leave")
                group.leave()
            }
        }
//        group.wait()
        group.enter()
        print("2 start")
        task2.async(group: group, qos: .default) { [weak self] in
            self?.apiManager.getSpeedMasureInfo(offset: 10) {_,_,_ in
                print("2 leave")
//                group.wait()
                group.leave()
            }
        }
//        group.wait()
        group.enter()
        print("3 start")
        task3.async(group: group, qos: .default) { [weak self] in
            self?.apiManager.getSpeedMasureInfo(offset: 20) {_,_,_ in
                print("3 leave")
//                group.wait()
                group.leave()
            }
        }
        
        group.notify(queue: .main) { [weak self] in
            var index = 0
            for _ in 0...2 {
                print("🦄")
            }
            self?.firstRoadLabel.text = self?.apiManager.SpeedMeasuredInfos[0].road
            self?.firstSpeedLabel.text = self?.apiManager.SpeedMeasuredInfos[0].speedLimit
            self?.secondRoadLabel.text = self?.apiManager.SpeedMeasuredInfos[1].road
            self?.secondSpeedLabel.text = self?.apiManager.SpeedMeasuredInfos[1].speedLimit
            self?.thirdRoadLabel.text = self?.apiManager.SpeedMeasuredInfos[2].road
            self?.thirdSpeedLabel.text = self?.apiManager.SpeedMeasuredInfos[2].speedLimit
        }
    }
    
    @objc func semaphore() {
        defaultString()
//        oneByOne()
        
        print("======semaphore======")
        let task = DispatchQueue(label: "semaphore.getSpeedMasureInfo")
        let semaphore = DispatchSemaphore(value: 1)
        let group = DispatchGroup()

        
        task.async(group: group, qos: .default) { [weak self] in
            for index in 0...2 {
                print("\(index) start")
                self?.apiManager.getSpeedMasureInfo(offset: index) {[weak self] info,_,_ in
                    print("\(index) finish")
                    semaphore.wait()
                    DispatchQueue.main.sync {
                        print("\(index) show")
                        switch index{
                        case 0:
                            self?.firstRoadLabel.text = info?.road
                            self?.firstSpeedLabel.text = info?.speedLimit
                        case 1:
                            self?.secondRoadLabel.text = info?.road
                            self?.secondSpeedLabel.text = info?.speedLimit
                        case 2:
                            self?.thirdRoadLabel.text = info?.road
                            self?.thirdSpeedLabel.text = info?.speedLimit
                        default: return
                        }
                    }
                    print("\(index) signal")
                    semaphore.signal()
                }
            }
            
//            print("1 start")
//            self?.apiManager.getSpeedMasureInfo(offset: 0) {[weak self] info,_,_ in
//                print("1 finish")
//                semaphore.wait()
//                DispatchQueue.main.sync {
//                    self?.firstRoadLabel.text = info?.road
//                    self?.firstSpeedLabel.text = info?.speedLimit
//                    print("1 show")
//                    semaphore.signal()
//                }
//
//            }
//
//            print("2 start")
//            self?.apiManager.getSpeedMasureInfo(offset: 10) {[weak self] info,_,_ in
//
//                print("2 finish")
//                semaphore.wait()
//                DispatchQueue.main.sync {
//                    self?.secondRoadLabel.text = info?.road
//                    self?.secondSpeedLabel.text = info?.speedLimit
//                    print("2 show")
//                    semaphore.signal()
//                }
//            }
//
//            print("3 start")
//            self?.apiManager.getSpeedMasureInfo(offset: 20) {[weak self] info,_,_ in
//
//                print("3 finish")
//                semaphore.wait(timeout: .distantFuture)
//                DispatchQueue.main.sync {
//                    self?.thirdRoadLabel.text = info?.road
//                    self?.thirdSpeedLabel.text = info?.speedLimit
//                    semaphore.signal()
//                }
//                print("3 show")
//            }
        }
    }
    
//    func oneByOne() {
//        print("====oneByOne====")
//        print("1 start")
//        apiManager.getSpeedMasureInfo(offset: 0) {[weak self] info,_,_ in
//            DispatchQueue.main.sync {
//                print("1 finish")
//                self?.firstRoadLabel.text = info?.road
//                self?.firstSpeedLabel.text = info?.speedLimit
//
//            }
//        }
//
//        print("2 start")
//        apiManager.getSpeedMasureInfo(offset: 10) {[weak self] info,_,_ in
//            DispatchQueue.main.sync {
//                print("2 finish")
//                self?.secondRoadLabel.text = info?.road
//                self?.secondSpeedLabel.text = info?.speedLimit
//
//            }
//        }
//
//        print("3 start")
//        apiManager.getSpeedMasureInfo(offset: 20) {[weak self] info,_,_ in
//            DispatchQueue.main.sync {
//                print("3 finish")
//                self?.thirdRoadLabel.text = info?.road
//                self?.thirdSpeedLabel.text = info?.speedLimit
//
//            }
//        }
//    }
    
    func defaultString() {
        firstRoadLabel.text = "路段"
        firstSpeedLabel.text = "速限"
        secondRoadLabel.text = "路段"
        secondSpeedLabel.text = "速限"
        thirdRoadLabel.text = "路段"
        thirdSpeedLabel.text = "速限"
    }

//    func addSpeedMeasureView() {
//        firstSpeedMeasureView = SpeedMeasureView(frame: CGRect(x: 50, y: 50, width: 200, height: 200), name: "AAA", speed: "111")
//
//        self.view.addSubview(firstSpeedMeasureView)
//        firstSpeedMeasureView.translatesAutoresizingMaskIntoConstraints = false
//
//        NSLayoutConstraint.activate([
//            firstSpeedMeasureView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
//            firstSpeedMeasureView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
//        ])
//    }

}

class SpeedMeasureView: UIView {
//    let speedMeasureView = UIView()
    let roadNameLabel = UILabel()
    let speedLabel = UILabel()
    
    init(frame: CGRect, name: String, speed: String) {
        super.init(frame: frame)
        setUp(name: name, speed: speed)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUp(name: String, speed: String) {
        roadNameLabel.text = name
        speedLabel.text = speed
        self.addSubview(roadNameLabel)
        self.addSubview(speedLabel)
        roadNameLabel.translatesAutoresizingMaskIntoConstraints = false
        speedLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            roadNameLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            roadNameLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16),
            speedLabel.leadingAnchor.constraint(greaterThanOrEqualTo: roadNameLabel.trailingAnchor, constant: 100),
            speedLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            speedLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 16)
            ])
    }
}

