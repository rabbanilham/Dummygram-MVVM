//
//  AccountDetailViewModel.swift
//  DummygramMVVM
//
//  Created by Bagas Ilham on 09/08/22.
//

import Foundation

final class UserDetailViewModel: NSObject {
    
    var userId: String
    var api = DummygramAPI.shared
    var reloadTableView: (() -> Void)?
    var postSelected: ((DGPostResponse, PostCellViewModel) -> Void)?
    var user: DGUserLongResponse!
    var posts = [DGPostResponse]()
    var group = DispatchGroup()
    var cellViewModel: UserDetailCellViewModel!
    var postCellViewModel = [UserPostsCellViewModel]()
    var isLoadedPosts: Bool = false
    
    init(userId: String) {
        self.userId = userId
    }
    
    func initViewModel() {
        loadUser()
        loadPosts()
        group.notify(queue: .main) { [weak self] in
            guard let self = self else { return }
            self.reloadTableView?()
        }
    }
    
    func loadUser() {
        group.enter()
        api.getUserDetail(userId) { [weak self] result, error in
            guard let self = self, let result = result else {
                return
            }
            self.user = result
            let cellViewModel = UserDetailCellViewModel(
                userId: result.id,
                userImage: result.picture,
                firstName: result.firstName,
                lastName: result.lastName,
                userName: result.firstName.lowercased() + result.lastName.lowercased(),
                email: result.email,
                dateOfBirth: result.dateOfBirth,
                phoneNumber: result.phone,
                location: "\(result.location.street), \(result.location.city), \(result.location.state), \(result.location.country)"
            )
            self.cellViewModel = cellViewModel
            self.group.leave()
        }
    }
    
    func loadPosts() {
        group.enter()
        api.getUserPosts(userId) { [weak self] result, error in
            guard let self = self, let result = result else {
                return
            }
            self.posts = result.data
            for i in 0...(result.data.count - 1) {
                if i % 2 == 0, i != result.data.count - 1 {
                    let post = result.data
                    let leftImage = post[i].image
                    let rightImage = post[i + 1].image
                    let postViewModel = UserPostsCellViewModel(leftImage: leftImage, rightImage: rightImage)
                    self.postCellViewModel.append(postViewModel)
                } else if i % 2 == 0, i == result.data.count - 1 {
                    let post = result.data
                    let leftImage = post[i].image
                    let postViewModel = UserPostsCellViewModel(leftImage: leftImage, rightImage: nil)
                    self.postCellViewModel.append(postViewModel)
                }
                
            }
            self.isLoadedPosts = true
            self.group.leave()
        }
    }
    
    func goToPostDetail(postIndex: Int) {
        let post = posts[postIndex]
        let postViewModel = PostCellViewModel(
            userName: post.owner.firstName.lowercased() + post.owner.lastName.lowercased(),
            userImage: post.owner.picture,
            photo: post.image,
            caption: post.text,
            date: post.publishDate,
            likeCount: post.likes,
            publishDate: post.publishDate,
            isLiked: false
        )
        postSelected?(post, postViewModel)
    }
}
