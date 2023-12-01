//
//  Books.swift
//  Trantor
//
//  Created by Yery Castro on 23/11/23.
//

import Foundation

struct Book: Codable, Identifiable, Hashable {
    let author: UUID
    let year: Int
    let id: Int
    let title: String
    let isbn: String?
    let pages: Int?
    let rating: Double?
    let price: Double
    let cover: URL?
    let plot: String?
    let summary: String?
}
