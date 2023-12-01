//
//  URL.swift
//  Trantor
//
//  Created by Yery Castro on 23/11/23.
//

import Foundation

let api = URL(string: "https://trantorapi-acacademy.herokuapp.com/api/")!

extension URL {
    static let getBooks = api.appending(path: "books/list")
    static let getAuthors = api.appending(path: "books/authors")
}
