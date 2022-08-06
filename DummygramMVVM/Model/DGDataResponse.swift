//
//  DGDataResponse.swift
//  DummygramMVVM
//
//  Created by Bagas Ilham on 05/08/22.
//

import Foundation

struct DGDataResponse<T>: Codable where T: Codable {
    let data: [T]
    let total, page, limit: Int
}
