//
//  APIManager.swift
//  GCDDemo
//
//  Created by iching chen on 2019/8/22.
//  Copyright © 2019 ichingchen. All rights reserved.
//

import Foundation

class APIManager {
    static let manager = APIManager()
    
    private init(){}
    
    var SpeedMeasuredInfos: [Results] = []
    
    func getSpeedMasureInfo(offset: Int) {
        getSpeedMasureInfo(offset: offset){ info, result, error in
            
        }
    }
    
    func getSpeedMasureInfo(offset: Int, resultHandler:  @escaping (Results?, Bool, Error?) -> Void) {
        
//         let request = Request.speedMasure("1", String(offset))
        
        guard let url = URL(string: "https://data.taipei/opendata/datalist/apiAccess?scope=resourceAquire&rid=5012e8ba-5ace-4821-8482-ee07c147fd0a&limit=1&offset=\(offset)")
            else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) {[weak self] data, response, error in
            
            let httpResponse = response as! HTTPURLResponse
            // swiftlint:enable force_cast
            let statusCode = httpResponse.statusCode
            print(statusCode)
            
            guard let data = data else {
                resultHandler(nil, false, DecodError.noData)
                return
            }
            
            let decoder = JSONDecoder()
            //讓 decoder 自動把 SnakeCase 轉成 CamelCase
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            do {
                let speedMeasuredInfo = try decoder.decode(SpeedMeasuredInfo.self, from: data)
                
                let speedMeasureInfo = speedMeasuredInfo.result.results[0]
//                print("road = \(speedMeasureInfo.road)")
//                print("speedLimit = \(speedMeasureInfo.speedLimit)")
                
                self?.SpeedMeasuredInfos.append(speedMeasureInfo)
                resultHandler(speedMeasureInfo, true, nil)
                
            } catch let error {
                resultHandler(nil, false, error)
                print(error)
            }
            
        }
        task.resume()
        
    }
    
    enum DecodError: Error{
        case noData
    }
}

protocol STRequest {
    
    var headers: [String: String] { get }
    
    var body: Data? { get }
    
    var method: String { get }
    
    var endPoint: String { get }
}

extension STRequest {
    
    func makeRequest() -> URLRequest {
        
        let urlString = endPoint
        
        let url = URL(string: urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)!
        
        var request = URLRequest(url: url)
        
        request.allHTTPHeaderFields = headers
        
        request.httpBody = body
        
        request.httpMethod = method
        
        return request
    }
}

enum Request: STRequest {
    
    case speedMasure(String, String)
    
    var headers: [String: String] {
        switch self {
        case .speedMasure: return [:]
        }
    }
    
    var body: Data? {
        
        switch self {
        case .speedMasure: return nil
        }
    }
    
    var method: String {
        
        switch self {
        case .speedMasure:
            return "GET"
        }
    }
    
    var endPoint: String {
        
        switch self {
           
        case .speedMasure(_, let offset): return "https://data.taipei/opendata/datalist/apiAccess?scope=resourceAquire&rid=5012e8ba-5ace-4821-8482-ee07c147fd0a&limit=1&offset=\(offset)"
        }
    }
}
