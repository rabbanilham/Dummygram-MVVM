//
//  DGUserResponse.swift
//  DummygramMVVM
//
//  Created by Bagas Ilham on 05/08/22.
//

import Foundation

struct DGUserShortResponse: Codable {
    let id: String
    let title: String
    let firstName, lastName: String
    let picture: String
}

struct DGUserLongResponse: Codable {
    let id, title, firstName, lastName: String
    let picture: String
    let gender, email, dateOfBirth, phone: String
    let location: DGLocationResponse
    let registerDate, updatedDate: String
}

// MARK: - Location
struct DGLocationResponse: Codable {
    let street, city, state, country: String
    let timezone: String
}
