//
//  HomeViewController.swift
//  DummygramMVVM
//
//  Created by Bagas Ilham on 04/08/22.
//

import UIKit

final class HomeViewController: UITableViewController {
    
    private var viewModel = HomeViewModel()
    private var loadingIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.hidesWhenStopped = true
        indicator.center = CGPoint(x: UIScreen.main.bounds.width / 2, y: UIScreen.main.bounds.height / 2)
        return indicator
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        initializeViewModel()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.posts.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "\(HomeTableViewCell.self)", for: indexPath) as? HomeTableViewCell else { return UITableViewCell() }
        let row = indexPath.row
        let cellViewModel = viewModel.homeCellViewModel[row]
        cell.viewModel = cellViewModel
        cellViewModel.likeTapped = { [weak self] liked in
            guard let self = self else { return }
            self.handleCellLikeButtonTap(for: cell, liked: liked)
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let row = indexPath.row
        let post = viewModel.posts[row]
        goToPostDetail(post: post)
    }
    
    private func setupTableView() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "\(UITableViewCell.self)")
        tableView.register(HomeTableViewCell.self, forCellReuseIdentifier: "\(HomeTableViewCell.self)")
        tableView.separatorStyle = .none
        navigationItem.title = "Posts"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.useDGLargeTitle()
    }
    
    private func initializeViewModel() {
        loadingIndicator.startAnimating()
        viewModel.initViewModel()
        viewModel.reloadTableView = { [weak self] in
            guard let self = self else { return }
            self.tableView.reloadData()
            self.loadingIndicator.stopAnimating()
        }
    }

    private func goToPostDetail(post: DGPostResponse) {
        let viewController = PostDetailViewController(post: post)
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    private func handleCellLikeButtonTap(for cell: HomeTableViewCell, liked: Bool) {
        if liked {
            cell.likeButton.image = UIImage(systemName: "heart.fill")?.withTintColor(.systemRed, renderingMode: .alwaysOriginal)
        } else {
            cell.likeButton.image = UIImage(systemName: "heart")?.withTintColor(.label, renderingMode: .alwaysOriginal)
        }
    }

}

