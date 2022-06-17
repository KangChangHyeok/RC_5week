//
//  Movie.swift
//  MoiveApiProject
//
//  Created by 강창혁 on 2022/06/16.
//

import Foundation

// MARK: - Movie
struct Movie: Codable {
    let lastBuildDate: String
    let total, start, display: Int
    let items: [Item]
}

// MARK: - Item
struct Item: Codable {
    let title: String
    let link: String
    let image: String
    let subtitle, pubDate, director, actor: String
    let userRating: String
}
