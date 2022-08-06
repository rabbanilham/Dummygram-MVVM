//
//  DGPostResponse.swift
//  DummygramMVVM
//
//  Created by Bagas Ilham on 05/08/22.
//

import Foundation

struct DGPostResponse: Codable {
    let id: String
    let image: String
    let likes: Int
    let tags: [String]
    let text, publishDate: String
    let owner: DGUserShortResponse
}
