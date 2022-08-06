//
//  HomeViewModel.swift
//  DummygramMVVM
//
//  Created by Bagas Ilham on 05/08/22.
//

import Foundation

final class HomeViewModel: NSObject {
    private var api = DummygramAPI.shared
    var reloadTableView: (() -> Void)?
    var posts: [DGPostResponse] = []
    var homeCellViewModel = [HomeCellViewModel]() {
        didSet {
            reloadTableView?()
        }
    }
    
    func initViewModel() {
        loadPosts()
    }
    
    func loadPosts() {
        api.getPosts { [weak self] result, error in
            guard let self = self, let result = result else {
                return
            }
            self.posts = result.data
            var cellViewModels: [HomeCellViewModel] = []
            for post in result.data {
                let cellViewModel = HomeCellViewModel(
                    userName: post.owner.firstName.lowercased() + post.owner.lastName.lowercased(),
                    userImage: post.owner.picture,
                    photo: post.image,
                    caption: post.text,
                    date: post.publishDate,
                    likeCount: post.likes,
                    isLiked: false
                )
                cellViewModels.append(cellViewModel)
            }
            self.homeCellViewModel = cellViewModels
        }
    }
}
