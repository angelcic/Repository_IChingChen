//
//  SpeedMeasuredInfo.swift
//  GCDDemo
//
//  Created by iching chen on 2019/8/22.
//  Copyright © 2019 ichingchen. All rights reserved.
//

import Foundation

struct SpeedMeasuredInfo: Codable {
    let result: Result
}

struct Result: Codable {
    let results: [Results]
}

struct Results: Codable {
    let road: String
    let speedLimit: String
    
}

//"result": {
//    "limit": 1,
//    "offset": 0,
//    "count": 143,
//    "sort": "",
//    "results": [
//    {
//    "functions": "測速",
//    "area": "士林",
//    "no": "1",
//    "direction": "南向北",
//    "speed_limit": "50",
//    "location": "葫蘆街",
//    "_id": 1,
//    "road": "環河北路3段"
//    }
//    ]
//}
