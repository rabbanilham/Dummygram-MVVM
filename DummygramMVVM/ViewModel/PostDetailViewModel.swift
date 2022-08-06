//
//  PostDetailViewModel.swift
//  DummygramMVVM
//
//  Created by Bagas Ilham on 06/08/22.
//

import Foundation

final class PostDetailViewModel {
    var reloadTableView: (() -> Void)?
    var post: DGPostResponse?
    var comments: [DGCommentResponse] = [] {
        didSet {
            reloadTableView?()
        }
    }
    private var api = DummygramAPI.shared
    
    func initViewModel(postId: String) {
        loadPost(postId)
        loadComments(postId)
    }
    
    func loadPost(_ postId: String) {
        api.getPost(postId) { [weak self] result, error in
            guard let self = self, let result = result else {
                return
            }
            self.post = result
        }
    }
    
    func loadComments(_ postId: String) {
        api.getComments(postId) { [weak self] result, error in
            guard let self = self, let result = result else {
                return
            }
            self.comments = result.data
            self.reloadTableView?()
        }
    }
}
