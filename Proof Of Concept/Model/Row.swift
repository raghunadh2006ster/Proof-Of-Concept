//
//  Row.swift
//  Proof Of Concept
//
//  Created by Raghu on 21/12/20.
//

import Foundation

// MARK: - Welcome
struct Welcome: Codable {
    let title: String
    let rows: [Row]
}

// MARK: - Row
struct Row: Codable {
    let title, rowDescription: String?
    let imageHref: String?

    enum CodingKeys: String, CodingKey {
        case title
        case rowDescription = "description"
        case imageHref
    }
}
