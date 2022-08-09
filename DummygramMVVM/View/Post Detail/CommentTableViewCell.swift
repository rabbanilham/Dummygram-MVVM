//
//  CommentTableViewCell.swift
//  DummygramMVVM
//
//  Created by Bagas Ilham on 07/08/22.
//

import UIKit

final class CommentTableViewCell: UITableViewCell {
    
    var containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemBackground
        view.layer.cornerRadius = 18
        view.layer.masksToBounds = false
        view.layer.shadowRadius = 3
        view.layer.shadowColor = UIColor.label.cgColor
        view.layer.shadowOpacity = 0.3
        view.layer.shadowOffset = CGSize(width: 0, height: 0)
        return view
    }()
    
    var userImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.isUserInteractionEnabled = true
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 14
        return imageView
    }()
    
    var userNameLabel: UILabel = {
        let label = UILabel()
        label.isUserInteractionEnabled = true
        label.translatesAutoresizingMaskIntoConstraints = false
        label.useAppFont(weight: .medium, size: UIFont.labelFontSize)
        return label
    }()
    
    var commentLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.useAppFont(weight: .book, size: 16)
        label.numberOfLines = 0
        return label
    }()
    
    var commentDateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.useAppFont(weight: .book, size: 12)
        label.textColor = .secondaryLabel
        label.numberOfLines = 0
        return label
    }()
    
    var onUserNameTap: (() -> Void)?
    
    var viewModel: CommentViewModel? {
        didSet {
            if let photo = viewModel?.userImage, let url = URL(string: photo) {
                userImageView.kf.indicatorType = .activity
                userImageView.kf.setImage(with: url, options: [.transition(.fade(0.2))])
            }
            userNameLabel.text = viewModel?.userName
            commentLabel.text = viewModel?.comment
            if let date = viewModel?.commentDate {
                commentDateLabel.text = date.convertToDateInterval() + " ago"
            }
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        defineLayout()
        setupTapRecognizer()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func defineLayout() {
        contentView.addSubview(containerView)
        containerView.addSubviews(userImageView, userNameLabel, commentLabel, commentDateLabel)
        let margin = contentView.layoutMarginsGuide
        NSLayoutConstraint.activate([
            contentView.heightAnchor.constraint(greaterThanOrEqualToConstant: 10),
            
            containerView.topAnchor.constraint(equalTo: margin.topAnchor),
            containerView.widthAnchor.constraint(equalTo: margin.widthAnchor),
            containerView.bottomAnchor.constraint(equalTo: margin.bottomAnchor),
            containerView.centerXAnchor.constraint(equalTo: margin.centerXAnchor),
            
            userImageView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 8),
            userImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            userImageView.heightAnchor.constraint(equalToConstant: 28),
            userImageView.widthAnchor.constraint(equalTo: userImageView.heightAnchor),
            
            userNameLabel.centerYAnchor.constraint(equalTo: userImageView.centerYAnchor),
            userNameLabel.leadingAnchor.constraint(equalTo: userImageView.trailingAnchor, constant: 8),
            userNameLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            
            commentLabel.topAnchor.constraint(equalTo: userImageView.bottomAnchor, constant: 8),
            commentLabel.leadingAnchor.constraint(equalTo: userImageView.leadingAnchor),
            commentLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            commentLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -16),
            
            commentDateLabel.centerYAnchor.constraint(equalTo: userNameLabel.centerYAnchor),
            commentDateLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16)
        ])
    }
    
    private func setupTapRecognizer() {
        let imageTapRecognizer = UITapGestureRecognizer(target: self, action: #selector(userNameTapped))
        let labelTapRecognizer = UITapGestureRecognizer(target: self, action: #selector(userNameTapped))
        userImageView.addGestureRecognizer(imageTapRecognizer)
        userNameLabel.addGestureRecognizer(labelTapRecognizer)
    }
    
    @objc private func userNameTapped() {
        self.onUserNameTap?()
    }
}
