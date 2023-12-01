//
//  Authors.swift
//  Trantor
//
//  Created by Yery Castro on 23/11/23.
//

import Foundation

struct Author: Codable, Identifiable {
    let id: UUID
    let name: String
}
