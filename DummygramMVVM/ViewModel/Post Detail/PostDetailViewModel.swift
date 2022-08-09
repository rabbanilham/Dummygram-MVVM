//
//  PostDetailViewModel.swift
//  DummygramMVVM
//
//  Created by Bagas Ilham on 06/08/22.
//

import Foundation

final class PostDetailViewModel {
    var reloadTableView: (() -> Void)?
    var pushUserDetailController: ((DGUserShortResponse, UserDetailViewModel) -> Void)?
    var post: DGPostResponse
    var postViewModel: PostCellViewModel
    var comments = [DGCommentResponse]()
    var commentViewModels = [CommentViewModel]() {
        didSet {
            reloadTableView?()
        }
    }
    var group = DispatchGroup()
    private var api = DummygramAPI.shared
    var isLoadedComments: Bool = false
    
    init(post: DGPostResponse, postViewModel: PostCellViewModel) {
        self.postViewModel = postViewModel
        self.post = post
    }
    
    func initViewModel() {
        loadPost()
        loadComments(post.id)
        group.notify(queue: .main) { [weak self] in
            guard let self = self else { return }
            self.reloadTableView?()
        }
    }
    
    func loadPost() {
        group.enter()
        api.getPost(post.id) { [weak self] result, error in
            guard let self = self, let result = result else {
                return
            }
            self.postViewModel.caption = result.text
            self.group.leave()
        }
    }
    
    func loadComments(_ postId: String) {
        group.enter()
        api.getComments(postId) { [weak self] result, error in
            guard let self = self, let result = result else {
                return
            }
            var comments = [CommentViewModel]()
            for comment in result.data {
                let commentModel = CommentViewModel(
                    userImage: comment.owner.picture,
                    userName: comment.owner.firstName.lowercased() + comment.owner.lastName.lowercased(),
                    comment: comment.message,
                    commentDate: comment.publishDate
                )
                comments.append(commentModel)
            }
            self.comments = result.data
            self.commentViewModels = comments
            self.isLoadedComments = true
            self.group.leave()
        }
    }
    
    func goToUserDetailPage(row: Int) {
        let user = comments[row].owner
        let userViewModel = UserDetailViewModel(userId: user.id)
        self.pushUserDetailController?(user, userViewModel)
    }
}
