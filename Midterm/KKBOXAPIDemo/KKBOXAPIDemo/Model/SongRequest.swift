//
//  SongRequest.swift
//  KKBOXAPIDemo
//
//  Created by iching chen on 2019/8/23.
//  Copyright © 2019 ichingchen. All rights reserved.
//

import Foundation


enum SongRequest: Request {
    
    case newHits(_ token: String)
    
    var headers: [String: String] {
        
        switch self {
            
        case .newHits(let token):
            
            return [
                HTTPHeaderField.auth.rawValue: "Bearer \(token)",
            ]
        }
    }
    
    var body: Data? {
        
        switch self {
        case .newHits: return nil
            
        }
    }
    
    var method: String {
        
        switch self {
            
        case .newHits: return HTTPMethod.GET.rawValue
            
        }
    }
    
    var endPoint: String {
        
        switch self {
            
        case .newHits: return "/v1.1/new-hits-playlists/DZrC8m29ciOFY2JAm3/tracks?territory=TW&limit=20"
            
        }
        
    }
    
}

enum Result<T> {
    
    case success(T)
    
    case failure(Error)
}

enum HTTPClientError: Error {
    
    case decodeDataFail
    
    case clientError(Data)
    
    case serverError
    
    case unexpectedError
}

enum HTTPMethod: String {
    
    case GET
    
    case POST
}

enum HTTPHeaderField: String {
    case auth = "Authorization"
}

protocol Request {
    
    var headers: [String: String] { get }
    
    var body: Data? { get }
    
    var method: String { get }
    
    var endPoint: String { get }
}

extension Request {
    
    func makeRequest() -> URLRequest {
        
        let urlString = Bundle.main.infoDictionary!["KKBOXBaseURL"] as! String + endPoint
        print(urlString)
        
        let url = URL(string: urlString)!
        
        var request = URLRequest(url: url)
        
        request.allHTTPHeaderFields = headers
        
        request.httpBody = body
        
        request.httpMethod = method
        
        return request
    }
}
