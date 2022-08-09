//
//  UserImageCellViewModel.swift
//  DummygramMVVM
//
//  Created by Bagas Ilham on 09/08/22.
//

import Foundation

final class UserPostsCellViewModel: NSObject {
    var leftImage: String
    var rightImage: String?
    
    init(leftImage: String, rightImage: String?) {
        self.leftImage = leftImage
        self.rightImage = rightImage
    }
}
