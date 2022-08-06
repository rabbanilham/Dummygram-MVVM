//
//  PostDetailViewController.swift
//  DummygramMVVM
//
//  Created by Bagas Ilham on 06/08/22.
//

import UIKit

final class PostDetailViewController: UITableViewController {
    
    var post: DGPostResponse
    var viewModel = PostDetailViewModel()
    
    init(post: DGPostResponse) {
        self.post = post
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
        return viewModel.comments.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let row = indexPath.row
        let comment = viewModel.comments[row]
        var config = cell.defaultContentConfiguration()
        config.text = comment.message
        cell.contentConfiguration = config
        return cell
    }
    
    private func initializeViewModel() {
        viewModel.initViewModel(postId: post.id)
        viewModel.reloadTableView = { [weak self] in
            guard let self = self else { return }
            self.tableView.reloadData()
        }
    }
    
    private func setupTableView() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        navigationItem.title = "Comments"
    }
    
}
