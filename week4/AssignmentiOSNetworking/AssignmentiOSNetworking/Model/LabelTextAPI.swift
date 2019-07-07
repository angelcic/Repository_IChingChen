//
//  UIDataAPI.swift
//  AssignmentiOSNetworking
//
//  Created by iching chen on 2019/7/7.
//  Copyright © 2019 ichingchen. All rights reserved.
//

import Foundation

class LabelTextAPI {
    enum Endpoint: String {
        case textURL = "https://stations-98a59.firebaseio.com/practice.json"
        
        var url: URL {
            return URL(string: self.rawValue)!
        }
    }
    
    class func requestLabelText(completionHandler: @escaping (LabelText?, Error?) -> Void) {
        let url = Endpoint.textURL.url
        
        let task = URLSession.shared.dataTask(with: url){
            (data, responds, error) in
            guard let data = data else {
                completionHandler(nil, error)
                return
            }
            
            let decoder = JSONDecoder()
            let uiTextData = try! decoder.decode(LabelText.self,from: data)
            
            completionHandler(uiTextData, nil)
            
        }
        task.resume()
    }
    
}
