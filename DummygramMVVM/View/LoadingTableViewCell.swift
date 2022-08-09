//
//  LoadingTableViewCell.swift
//  DummygramMVVM
//
//  Created by Bagas Ilham on 07/08/22.
//

import UIKit

final class LoadingTableViewCell: UITableViewCell {
    var loadingIndicatorView: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.hidesWhenStopped = true
        indicator.startAnimating()
        indicator.color = .label
        return indicator
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        defineLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func defineLayout() {
        selectionStyle = .none
        contentView.addSubview(loadingIndicatorView)
        NSLayoutConstraint.activate([
            loadingIndicatorView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            loadingIndicatorView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
    
}
