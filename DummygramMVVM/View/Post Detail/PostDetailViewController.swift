//
//  PostDetailViewController.swift
//  DummygramMVVM
//
//  Created by Bagas Ilham on 06/08/22.
//

import UIKit

final class PostDetailViewController: UITableViewController {
    
    var viewModel: PostDetailViewModel!
    
    init(post: DGPostResponse, postViewModel: PostCellViewModel) {
        self.viewModel = PostDetailViewModel(post: post, postViewModel: postViewModel)
        super.init(style: .plain)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        initializeViewModel()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if viewModel.isLoadedComments, !viewModel.comments.isEmpty {
            return viewModel.comments.count + 1
        } else if viewModel.isLoadedComments, viewModel.comments.isEmpty {
            tableView.separatorStyle = .none
            return 2
        } else {
            return 1
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = indexPath.row
        if viewModel.isLoadedComments {
            switch row {
            case 0:
                return createPostCell(for: row, indexPath: indexPath)
            default:
                if viewModel.comments.isEmpty {
                    return createEmptyCell(for: indexPath)
                } else {
                    return createCommentCell(for: row, indexPath: indexPath)
                }
            }
        } else {
            return createLoadingCell(for: indexPath)
        }
    }
    
    private func initializeViewModel() {
        viewModel.initViewModel()
        viewModel.reloadTableView = { [weak self] in
            guard let self = self else { return }
            self.tableView.reloadData()
        }
        viewModel.pushUserDetailController = { [weak self] user, userViewModel in
            guard let self = self else { return }
            let viewController = UserDetailViewController(viewModel: userViewModel)
            viewController.navigationItem.title = user.firstName.lowercased() + user.lastName.lowercased()
            self.navigationController?.pushViewController(viewController, animated: true)
        }
    }
    
    private func setupTableView() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.register(LoadingTableViewCell.self, forCellReuseIdentifier: "\(LoadingTableViewCell.self)")
        tableView.register(CommentTableViewCell.self, forCellReuseIdentifier: "\(CommentTableViewCell.self)")
        tableView.register(PostTableViewCell.self, forCellReuseIdentifier: "\(PostTableViewCell.self)")
        tableView.separatorStyle = .none
        navigationItem.title = "Comments"
        navigationItem.largeTitleDisplayMode = .always
    }
    
    private func createEmptyCell(for indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.selectionStyle = .none
        var config = cell.defaultContentConfiguration()
        cell.selectionStyle = .none
        config.attributedText = NSAttributedString(
            string: "There's no comments yet.",
            attributes: [
                .font : UIFont(name: "CircularStd-Book", size: 16)!,
                .foregroundColor : UIColor.secondaryLabel
            ]
        )
        cell.contentConfiguration = config
        return cell
    }
    
    private func createCommentCell(for row: Int, indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: "\(CommentTableViewCell.self)",
            for: indexPath
        ) as? CommentTableViewCell
        else { return UITableViewCell() }
        cell.selectionStyle = .none
        let cellViewModel = viewModel.commentViewModels[row - 1]
        cell.viewModel = cellViewModel
        cell.onUserNameTap = { [weak self] in
            guard let self = self else { return }
            self.viewModel.goToUserDetailPage(row: row - 1)
        }
        return cell
    }
    
    private func createPostCell(for row: Int, indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: "\(PostTableViewCell.self)",
            for: indexPath
        ) as? PostTableViewCell
        else { return UITableViewCell() }
        cell.selectionStyle = .none
        cell.viewModel = viewModel.postViewModel
        cell.blurView.isHidden = true
        return cell
    }
    
    private func createLoadingCell(for indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "\(LoadingTableViewCell.self)", for: indexPath) as? LoadingTableViewCell else { return UITableViewCell() }
        return cell
    }
    
}
