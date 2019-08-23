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
        guard
            let url = URL(string: "https://api.kkbox.com/v1.1/new-hits-playlists/DZrC8m29ciOFY2JAm3/tracks?territory=TW&limit=20")
            else { return }
        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = ["Authorization": "Bearer xLlSfIg0COXxDhtfBc+U9g=="]
        request.httpMethod = "GET"
        httpRequest(request: request) {[weak self] result in
//        httpRequest(request: SongRequest.newHits(KKBoxToken)) {[weak self] result in
            switch result {
            case .success(let data):
                
                let decoder = JSONDecoder()
                //讓 decoder 自動把 SnakeCase 轉成 CamelCase
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                do {
                    let songObject = try decoder.decode(SongObject.self, from: data)
                    
                    print("下載 \(songObject.data.count) 筆資料 ")
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
    
    func fetchMoreNewHits(resultHandler: @escaping (Bool, Error?) -> Void) {
        guard
            let nextPage = nextPage,
            let url = URL(string: nextPage)
        else {
            print("沒有更多資料了！！")
            return
        }
        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = ["Authorization": "Bearer xLlSfIg0COXxDhtfBc+U9g=="]
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
    
    func httpRequest(request: Request, completion: @escaping (Result<Data>) -> Void
        ) {
        httpRequest(request: request.makeRequest(), completion: completion)
    }
    
    
    func httpRequest(request: URLRequest, completion: @escaping (Result<Data>) -> Void
        ) {
        
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