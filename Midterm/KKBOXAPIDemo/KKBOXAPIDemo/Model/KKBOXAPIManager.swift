//
//  KKBOXAPIManager.swift
//  KKBOXAPIDemo
//
//  Created by iching chen on 2019/8/23.
//  Copyright © 2019 ichingchen. All rights reserved.
//

import Foundation

class KKBOXAPIManager {
    static let manager = KKBOXAPIManager()
    
    private init() {}
    
    var songList: [SongData] = []
    var songObject: SongObject?
    var nextPage: String?
    let KKBoxToken = Bundle.main.infoDictionary!["KKBOXAccessToken"] as! String
    
    func fetchNewHits(resultHandler: @escaping (Bool, Error?) -> Void) {
       
        httpRequest(request: SongRequest.newHits(KKBoxToken)) {[weak self] result in
            switch result {
            case .success(let data):
                
                let decoder = JSONDecoder()
                //讓 decoder 自動把 SnakeCase 轉成 CamelCase
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                do {
                    let songObject = try decoder.decode(SongObject.self, from: data)
                    
                    self?.songObject = songObject
                    self?.songList += songObject.data
                    self?.nextPage = songObject.paging.next
                    
                    resultHandler(true, nil)
                    
                } catch let error {
                    resultHandler(false, error)
                    print(error)
                }
                
            case .failure(let error):
                resultHandler(false, error)
            }
        }
    }
    
    func fetchMoreNewHits(resultHandler: @escaping (Bool, Error?) -> Void) {
        guard
            let nextPage = nextPage,
            let url = URL(string: nextPage)
            else {
                resultHandler(false, FetchError.noMorePage)
                return
        }
        // 用 KKBOX 提供的下一頁 url 來要資料
        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = ["Authorization": "Bearer \(KKBoxToken)"]
        request.httpMethod = "GET"
        
        httpRequest(request: request) {[weak self] result in
            switch result {
            case .success(let data):
                
                let decoder = JSONDecoder()
                //讓 decoder 自動把 SnakeCase 轉成 CamelCase
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                do {
                    let songObject = try decoder.decode(SongObject.self, from: data)
                    
                    print("下載 \(songObject.data.count) 筆資料 ")
                    print("已下載 \(self?.songList.count) 筆資料 ")
                    print("共有 \(songObject.summary.total) 筆資料")
                    
                    self?.songObject = songObject
                    self?.songList += songObject.data
                    self?.nextPage = songObject.paging.next
                    
                    resultHandler(true, nil)
                    
                } catch let error {
                    resultHandler(false, error)
                    print(error)
                }
                
            case .failure(let error):
                resultHandler(false, error)
            }
        }
    }
    
    enum FetchError: Error {
        case noMorePage
    }
    
    func httpRequest(request: Request,
                     completion: @escaping (Result<Data>) -> Void) {
        httpRequest(request: request.makeRequest(), completion: completion)
    }
    
    
    func httpRequest(request: URLRequest,
                     completion: @escaping (Result<Data>) -> Void) {
        
        URLSession.shared.dataTask(
            with: request,
            completionHandler: { (data, response, error) in
                
                guard error == nil else {
                    
                    return completion(Result.failure(error!))
                }
                
                let httpResponse = response as! HTTPURLResponse
                let statusCode = httpResponse.statusCode
                
                switch statusCode {
                    
                case 200..<300:
                    
                    completion(Result.success(data!))
                    
                case 400..<500:
                    completion(Result.failure(HTTPClientError.clientError(data!)))
                    
                case 500..<600:
                    
                    completion(Result.failure(HTTPClientError.serverError))
                    
                default: return
                    
                    completion(Result.failure(HTTPClientError.unexpectedError))
                }
                
        }).resume()
    }
}
