//
//  ViewController.swift
//  AssignmentiOSNetworking
//
//  Created by iching chen on 2019/7/6.
//  Copyright © 2019 ichingchen. All rights reserved.
//

//3. Please complete this assginment in a ​new​ app.
//URL : https://stations-98a59.firebaseio.com/practice.json Method: GET
//Authorization: None
//Response:
//{
//    "stationID": "R3",
//    "stationName": "Siaogang",
//    "stationAddress":"高雄市小港區沿海一路280號地下一樓" }
//    ● Only consider ​iPhone 8​ screen size when implementing this app.
//        ● Here’re the UI requirements and the distance mentioned below are using pixel as unit
//            ● You should also complete this assignment with ​asynchronous​ task.

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var stationIDLabel: UILabel!
    
    @IBOutlet weak var stationNameLabel: UILabel!
    
    @IBOutlet weak var addressLabel: UILabel!
    
    let url = "https://stations-98a59.firebaseio.com/practice.json"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        LabelTextAPI.requestLabelText(completionHandler: hanleLabelTextResponse(labeltext:error:))
    }
    
    func hanleLabelTextResponse(labeltext: LabelText?, error: Error?) {
        DispatchQueue.main.async {
            self.setUIText(stationID: labeltext?.stationID , stationName: labeltext?.stationName, stationAddress: labeltext?.stationAddress)
        }
    }    

    func setUIText(stationID: String?, stationName: String?, stationAddress: String?) {
        stationIDLabel.text = stationID
        stationNameLabel.text = stationName
        addressLabel.text = stationAddress
    }
}

