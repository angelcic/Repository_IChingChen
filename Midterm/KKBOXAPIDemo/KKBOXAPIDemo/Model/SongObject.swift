//
//  SongOblect.swift
//  KKBOXAPIDemo
//
//  Created by iching chen on 2019/8/23.
//  Copyright © 2019 ichingchen. All rights reserved.
//

import Foundation

struct SongObject: Codable {
    let data: [SongData]
    let paging: Paging
    let summary: Summary
}

struct SongData: Codable {
    let name: String
    let album: Album
}

struct Album: Codable {
    let name: String
    let images: [Image]
}

struct Image: Codable {
    let height: Int
    let width: Int
    let url: String
}

struct Paging: Codable {
    let offset: Int
    let limit: Int
    let previous: String?
    let next: String?
}

struct Summary: Codable {
    let total: Int
}
