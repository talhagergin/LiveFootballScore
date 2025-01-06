//
//  GeneralNews.swift
//  LiveFootballScore
//
//  Created by Talha Gergin on 5.01.2025.
//

import Foundation

// Haber sayfa bilgisi
struct Page: Decodable {
    let url: String
}

// Haber modeli
struct News: Decodable, Identifiable {
    let id: String
    let imageUrl: String
    let title: String
    let gmtTime: String
    let sourceStr: String
    let sourceIconUrl: String?
    let page: Page
}
// API yanıtı için ana model
struct APIResponseNews: Decodable {
    let status: String
    let response: NewsResponse
}

// Haberlerin listesini içeren model
struct NewsResponse: Decodable {
    let news: [News]
}
