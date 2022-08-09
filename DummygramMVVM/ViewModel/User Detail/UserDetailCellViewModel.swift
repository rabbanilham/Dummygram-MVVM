//
//  UserDetailCellViewModel.swift
//  DummygramMVVM
//
//  Created by Bagas Ilham on 09/08/22.
//

import Foundation

final class UserDetailCellViewModel: NSObject {
    var userId: String
    var userImage: String
    var firstName: String
    var lastName: String
    var userName: String
    var email: String
    var dateOfBirth: String
    var phoneNumber: String
    var location: String
    
    init(userId: String, userImage: String, firstName: String, lastName: String, userName: String, email: String, dateOfBirth: String, phoneNumber: String, location: String) {
        self.userId = userId
        self.userImage = userImage
        self.firstName = firstName
        self.lastName = lastName
        self.userName = userName
        self.email = email
        self.dateOfBirth = dateOfBirth.convertToDate(format: "dd MMMM yyyy")
        self.phoneNumber = phoneNumber
        self.location = location
    }
}
