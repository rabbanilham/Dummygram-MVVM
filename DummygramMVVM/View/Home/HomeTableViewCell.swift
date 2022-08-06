//
//  HomeTableViewCell.swift
//  DummygramMVVM
//
//  Created by Bagas Ilham on 05/08/22.
//

import UIKit
import Kingfisher

final class HomeTableViewCell: UITableViewCell {
    
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
    
    var photoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 12
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    var userImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 18
        return imageView
    }()
    
    var userNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.useAppFont(weight: .medium, size: UIFont.labelFontSize)
        return label
    }()
    
    var captionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.useAppFont(weight: .book, size: 14)
        label.numberOfLines = 0
        return label
    }()
    
    var blurView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        let blurEffect = UIBlurEffect(style: .regular)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(blurEffectView)
        view.clipsToBounds = true
        view.layer.cornerRadius = 18
        return view
    }()
    
    var likeButton: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(systemName: "heart")?.withTintColor(.label, renderingMode: .alwaysOriginal)
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    
    var likeCountLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.useAppFont(weight: .medium, size: 14)
        label.numberOfLines = 0
        return label
    }()
    
    var commentButton: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(systemName: "bubble.left")?.withTintColor(.label, renderingMode: .alwaysOriginal)
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    
    var onLikeButtonTap: (() -> Void)?
    var onCommentButtonTap: (() -> Void)?
    
    var viewModel: HomeCellViewModel? {
        didSet {
            if let string = viewModel?.photo, let url = URL(string: string) {
                photoImageView.kf.indicatorType = .activity
                photoImageView.kf.setImage(with: url, options: [.transition(.fade(0.2))])
            }
            if let string = viewModel?.userImage, let url = URL(string: string) {
                userImageView.kf.indicatorType = .activity
                userImageView.kf.setImage(with: url, options: [.transition(.fade(0.2))])
            }
            userNameLabel.text = viewModel?.userName
            captionLabel.text = viewModel?.caption
            if let likes = viewModel?.likeCount {
                likeCountLabel.text = "\(likes)"
            }
            if let liked = viewModel?.isLiked {
                if liked {
                    likeButton.image = UIImage(systemName: "heart.fill")?.withTintColor(.systemRed, renderingMode: .alwaysOriginal)
                } else {
                    likeButton.image = UIImage(systemName: "heart")?.withTintColor(.label, renderingMode: .alwaysOriginal)
                }
            }
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        defineLayout()
        setupButtonRecognizers()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func defineLayout() {
        selectionStyle = .none
        contentView.addSubview(containerView)
        containerView.addSubviews(userImageView, photoImageView, blurView, userNameLabel, captionLabel)
        blurView.addSubviews(likeButton, likeCountLabel, commentButton)
        let margin = contentView.layoutMarginsGuide
        NSLayoutConstraint.activate([
            contentView.heightAnchor.constraint(greaterThanOrEqualToConstant: 10),
            
            containerView.topAnchor.constraint(equalTo: margin.topAnchor),
            containerView.bottomAnchor.constraint(equalTo: margin.bottomAnchor),
            containerView.widthAnchor.constraint(equalTo: margin.widthAnchor),
            containerView.centerXAnchor.constraint(equalTo: margin.centerXAnchor),
            
            photoImageView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 8),
            photoImageView.widthAnchor.constraint(equalTo: containerView.widthAnchor, constant: -16),
            photoImageView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            photoImageView.heightAnchor.constraint(equalTo: photoImageView.widthAnchor),
            
            userImageView.topAnchor.constraint(equalTo: photoImageView.bottomAnchor, constant: 12),
            userImageView.leadingAnchor.constraint(equalTo: photoImageView.leadingAnchor, constant: 8),
            userImageView.heightAnchor.constraint(equalToConstant: 36),
            userImageView.widthAnchor.constraint(equalTo: userImageView.heightAnchor),
            
            userNameLabel.centerYAnchor.constraint(equalTo: userImageView.centerYAnchor),
            userNameLabel.leadingAnchor.constraint(equalTo: userImageView.trailingAnchor, constant: 8),
            userNameLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            
            captionLabel.topAnchor.constraint(equalTo: userImageView.bottomAnchor, constant: 8),
            captionLabel.leadingAnchor.constraint(equalTo: photoImageView.leadingAnchor, constant: 8),
            captionLabel.trailingAnchor.constraint(equalTo: photoImageView.trailingAnchor, constant: -8),
            captionLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -16),
            
            blurView.bottomAnchor.constraint(equalTo: photoImageView.bottomAnchor, constant: -8),
            blurView.trailingAnchor.constraint(equalTo: photoImageView.trailingAnchor, constant: -8),
            blurView.heightAnchor.constraint(equalToConstant: 36),
            blurView.widthAnchor.constraint(greaterThanOrEqualToConstant: 10),
            
            likeButton.centerYAnchor.constraint(equalTo: blurView.centerYAnchor),
            likeButton.leadingAnchor.constraint(equalTo: blurView.leadingAnchor, constant: 8),
            likeButton.trailingAnchor.constraint(equalTo: likeCountLabel.leadingAnchor, constant: -4),
            likeButton.heightAnchor.constraint(equalToConstant: 20),
            likeButton.widthAnchor.constraint(equalTo: likeButton.heightAnchor),
            
            likeCountLabel.centerYAnchor.constraint(equalTo: likeButton.centerYAnchor),
            likeCountLabel.trailingAnchor.constraint(equalTo: commentButton.leadingAnchor, constant: -16),
            
            commentButton.centerYAnchor.constraint(equalTo: blurView.centerYAnchor),
            commentButton.trailingAnchor.constraint(equalTo: blurView.trailingAnchor, constant: -8),
            commentButton.heightAnchor.constraint(equalToConstant: 20),
            commentButton.widthAnchor.constraint(equalTo: commentButton.heightAnchor),
        ])
    }
    
    private func setupButtonRecognizers() {
        let likeTapRecognizer = UITapGestureRecognizer(target: self, action: #selector(likeButtonTapped))
        let commentTapRecognizer = UITapGestureRecognizer(target: self, action: #selector(commentButtonTapped))
        likeButton.addGestureRecognizer(likeTapRecognizer)
        commentButton.addGestureRecognizer(commentTapRecognizer)
    }
    
    @objc private func likeButtonTapped() {
        self.viewModel?.toggleLike()
    }
    
    @objc private func commentButtonTapped() {
        self.onCommentButtonTap?()
    }
    
}
