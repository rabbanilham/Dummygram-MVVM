//
//  UserDetailViewController.swift
//  DummygramMVVM
//
//  Created by Bagas Ilham on 09/08/22.
//

import UIKit

final class UserDetailViewController: UITableViewController {
    
    var viewModel: UserDetailViewModel
    
    init(viewModel: UserDetailViewModel) {
        self.viewModel = viewModel
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
        if viewModel.posts.count % 2 == 0 {
            return (viewModel.posts.count / 2) + 1
        } else {
            return ((viewModel.posts.count + 1) / 2) + 1
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = indexPath.row
        if row == 0 {
            if viewModel.isLoadedPosts {
                return createUserDetailCell(for: indexPath)
            } else {
                return createLoadingCell(for: indexPath)
            }
        } else {
            return createUserPostCell(for: row, indexPath: indexPath)
        }
    }
    
    private func setupTableView() {
        tableView.separatorStyle = .none
        tableView.register(LoadingTableViewCell.self, forCellReuseIdentifier: "\(LoadingTableViewCell.self)")
        tableView.register(UserDetailTableCell.self, forCellReuseIdentifier: "\(UserDetailTableCell.self)")
        tableView.register(UserPostViewCell.self, forCellReuseIdentifier: "\(UserPostViewCell.self)")
        navigationItem.largeTitleDisplayMode = .never
    }
    
    private func initializeViewModel() {
        viewModel.initViewModel()
        viewModel.reloadTableView = { [weak self] in
            guard let self = self else { return }
            self.tableView.reloadData()
        }
        viewModel.postSelected = { [weak self] post, postViewModel in
            guard let self = self else { return }
            let viewController = PostDetailViewController(post: post, postViewModel: postViewModel)
            self.navigationController?.pushViewController(viewController, animated: true)
        }
    }
    
    private func createLoadingCell(for indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "\(LoadingTableViewCell.self)", for: indexPath) as? LoadingTableViewCell else { return UITableViewCell() }
        return cell
    }
    
    private func createUserDetailCell(for indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "\(UserDetailTableCell.self)", for: indexPath) as? UserDetailTableCell else { return UITableViewCell() }
        cell.viewModel = viewModel.cellViewModel
        return cell
    }
    
    private func createUserPostCell(for row: Int, indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "\(UserPostViewCell.self)", for: indexPath) as? UserPostViewCell else { return UITableViewCell() }
        cell.viewModel = viewModel.postCellViewModel[row - 1]
        cell.onLeftImageTap = { [weak self] in
            guard let self = self else { return }
            self.viewModel.goToPostDetail(postIndex: ((row - 1) * 2))
        }
        cell.onRightImageTap = { [weak self] in
            guard let self = self else { return }
            self.viewModel.goToPostDetail(postIndex: ((row - 1) * 2) + 1)
        }
        return cell
    }
    
}
