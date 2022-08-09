//
//  CommentViewModel.swift
//  DummygramMVVM
//
//  Created by Bagas Ilham on 07/08/22.
//

import Foundation

final class CommentViewModel: NSObject {
    var userImage: String
    var userName: String
    var comment: String
    var commentDate: String
    
    init(userImage: String, userName: String, comment: String, commentDate: String) {
        self.userImage = userImage
        self.userName = userName
        self.comment = comment
        self.commentDate = commentDate
    }
}
