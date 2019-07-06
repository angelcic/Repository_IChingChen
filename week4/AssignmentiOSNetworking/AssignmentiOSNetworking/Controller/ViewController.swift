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
        urlRequest()
    }
    
    func urlRequest() {
        guard let url = URL(string: url) else {
            print("Cannot create URL")
            return
        }
        let task = URLSession.shared.dataTask(with: url) {
            (data, responds, error) in
            guard let data = data else {
                print("no data, orthere was an error")
                return
            }
            
            let decoder = JSONDecoder()
            let uiTextData = try! decoder.decode(UIText.self,from: data)
            
            //更新UI Text
            DispatchQueue.main.async {
                self.setUIText(stationID: uiTextData.stationID , stationName: uiTextData.stationName, stationAddress: uiTextData.stationAddress)
            }
            
        }
        task.resume()
        
    }

    func setUIText(stationID: String?, stationName: String?, stationAddress: String?) {
        stationIDLabel.text = stationID
        stationNameLabel.text = stationName
        addressLabel.text = stationAddress
    }
}

