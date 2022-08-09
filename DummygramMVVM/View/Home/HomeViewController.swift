//
//  HomeViewController.swift
//  DummygramMVVM
//
//  Created by Bagas Ilham on 04/08/22.
//

import UIKit

final class HomeViewController: UITableViewController {
    
    private var viewModel = HomeViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        initializeViewModel()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if viewModel.isLoadedPosts {
            return viewModel.posts.count
        } else {
            return 1
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = indexPath.row
        if viewModel.isLoadedPosts {
            return createPostCell(for: row, indexPath: indexPath)
        } else {
            return createLoadingCell(for: indexPath)
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if viewModel.isLoadedPosts {
            let row = indexPath.row
            let post = viewModel.posts[row]
            let postViewModel = viewModel.homeCellViewModel[row]
            goToPostDetail(post: post, postViewModel: postViewModel)
        }
    }
    
    private func setupTableView() {
        tableView.register(LoadingTableViewCell.self, forCellReuseIdentifier: "\(LoadingTableViewCell.self)")
        tableView.register(PostTableViewCell.self, forCellReuseIdentifier: "\(PostTableViewCell.self)")
        tableView.separatorStyle = .none
        navigationItem.title = "Posts"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.useDGLargeTitle()
        navigationController?.navigationItem.backBarButtonItem?.setTitleTextAttributes([.font : UIFont(name: "CircularStd-Book", size: 18)!], for: .normal)
        
        let clearCacheButton = UIBarButtonItem(image: UIImage(systemName: "xmark.bin"), style: .plain, target: self, action: #selector(clearCache))
        navigationItem.leftBarButtonItem = clearCacheButton
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

    private func goToPostDetail(post: DGPostResponse, postViewModel: PostCellViewModel) {
        let viewController = PostDetailViewController(post: post, postViewModel: postViewModel)
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    private func createLoadingCell(for indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "\(LoadingTableViewCell.self)", for: indexPath) as? LoadingTableViewCell else { return UITableViewCell() }
        return cell
    }
    
    private func createPostCell(for row: Int, indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "\(PostTableViewCell.self)", for: indexPath) as? PostTableViewCell else { return UITableViewCell() }
       
        let cellViewModel = viewModel.homeCellViewModel[row]
        cell.viewModel = cellViewModel
        cellViewModel.likeTapped = { [weak self] liked in
            guard let _ = self else { return }
            if liked {
                cell.liked()
            } else {
                cell.disliked()
            }
        }
        cellViewModel.userNameTapped = { [weak self] in
            guard let self = self else { return }
            self.viewModel.goToUserDetailPage(row: row)
        }
        return cell
    }
    
    @objc private func clearCache() {
        viewModel.clearImageCache()
    }

}

