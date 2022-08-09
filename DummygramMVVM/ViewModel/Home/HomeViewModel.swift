//
//  HomeViewModel.swift
//  DummygramMVVM
//
//  Created by Bagas Ilham on 05/08/22.
//

import Foundation
import Kingfisher

final class HomeViewModel: NSObject {
    private var api = DummygramAPI.shared
    var reloadTableView: (() -> Void)?
    var pushUserDetailController: ((DGUserShortResponse, UserDetailViewModel) -> Void)?
    var posts: [DGPostResponse] = []
    var homeCellViewModel = [PostCellViewModel]() {
        didSet {
            reloadTableView?()
        }
    }
    var isLoadedPosts: Bool = false
    
    func initViewModel() {
        loadPosts()
    }
    
    func loadPosts() {
        api.getPosts { [weak self] result, error in
            guard let self = self, let result = result else {
                return
            }
            self.posts = result.data
            var cellViewModels: [PostCellViewModel] = []
            for post in result.data {
                let cellViewModel = PostCellViewModel(
                    userName: post.owner.firstName.lowercased() + post.owner.lastName.lowercased(),
                    userImage: post.owner.picture,
                    photo: post.image,
                    caption: post.text,
                    date: post.publishDate,
                    likeCount: post.likes,
                    publishDate: post.publishDate,
                    isLiked: false
                )
                cellViewModels.append(cellViewModel)
            }
            self.isLoadedPosts = true
            self.homeCellViewModel = cellViewModels
        }
    }
    
    func goToUserDetailPage(row: Int) {
        let user = posts[row].owner
        let viewModel = UserDetailViewModel(userId: user.id)
        self.pushUserDetailController?(user, viewModel)
    }
    
    func clearImageCache() {
        Kingfisher.KingfisherManager.shared.cache.clearCache()
    }
}
