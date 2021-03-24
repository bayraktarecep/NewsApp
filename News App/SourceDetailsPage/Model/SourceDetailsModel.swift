//
//  SourceDetailsModel.swift
//  News App
//
//  Created by Recep Bayraktar on 23.03.2021.
//

import Foundation

struct NewsResult: Codable {
    let articles: [NewsModel]
    let totalResults: Int?
}

struct NewsModel: Codable {
    let source: SourceModel?
    let title: String?
    let description: String?
    let author: String?
    let url: String?
    let urlToImage: String
    let publishedAt: String?
    let content: String?
}

struct SourceModel: Codable {
    let id: String?
    let name: String?
}
