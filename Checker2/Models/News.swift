//
//  News.swift
//  Checker2
//
//  Created by bmtech on 25.07.2022.
//

import Foundation

struct News : Codable {
    var status: String
    var totalResults: Int
    var articles: [Articles]
}

struct NewsFavorites : Codable {
    var status: String
    var totalResults: Int
    var articles: [Articles]
}

struct Articles : Codable {
    var title: String
    var description: String?
    var content: String?
    var url: String
    var urlToImage: String?
    var publishedAt: String?
}
