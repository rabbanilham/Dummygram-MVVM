//
//  DGCommentResponse.swift
//  DummygramMVVM
//
//  Created by Bagas Ilham on 06/08/22.
//

import Foundation

struct DGCommentResponse: Codable {
    let id, message: String
    let owner: DGUserShortResponse
    let post, publishDate: String
}
