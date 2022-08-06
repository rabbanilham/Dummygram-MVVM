//
//  HomeCellViewModel.swift
//  DummygramMVVM
//
//  Created by Bagas Ilham on 05/08/22.
//

import Foundation

final class HomeCellViewModel: NSObject {
    var likeTapped: ((Bool) -> Void)?
    var userName: String
    var userImage: String
    var photo: String
    var caption: String
    var date: String
    var likeCount: Int
    var isLiked: Bool
    
    init(userName: String, userImage: String, photo: String, caption: String, date: String, likeCount: Int, isLiked: Bool) {
        self.userName = userName
        self.userImage = userImage
        self.photo = photo
        self.caption = caption
        self.date = date
        self.likeCount = likeCount
        self.isLiked = isLiked
    }
    
    func toggleLike() {
        isLiked.toggle()
        likeTapped?(isLiked)
    }
    
}
