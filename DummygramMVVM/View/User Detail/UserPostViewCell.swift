//
//  UserPostViewCell.swift
//  DummygramMVVM
//
//  Created by Bagas Ilham on 09/08/22.
//

import UIKit

final class UserPostViewCell: UITableViewCell {
    
    var leftImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.isUserInteractionEnabled = true
        imageView.clipsToBounds = true
        return imageView
    }()
    
    var rightImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.isUserInteractionEnabled = true
        imageView.clipsToBounds = true
        return imageView
    }()
    
    var onLeftImageTap: (() -> Void)?
    var onRightImageTap: (() -> Void)?
    
    var viewModel: UserPostsCellViewModel? {
        didSet {
            if let string = viewModel?.leftImage, let url = URL(string: string) {
                leftImageView.kf.indicatorType = .activity
                leftImageView.kf.setImage(with: url, options: [.transition(.fade(0.2))])
            }
            if let string = viewModel?.rightImage, let url = URL(string: string) {
                rightImageView.kf.indicatorType = .activity
                rightImageView.kf.setImage(with: url, options: [.transition(.fade(0.2))])
            }
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        defineLayout()
        setupTapRecognizers()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func defineLayout() {
        selectionStyle = .none
        contentView.addSubviews(leftImageView, rightImageView)
        NSLayoutConstraint.activate([
            contentView.heightAnchor.constraint(greaterThanOrEqualToConstant: 10),
            
            leftImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 2),
            leftImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            leftImageView.widthAnchor.constraint(equalToConstant: (UIScreen.main.bounds.width / 2) - 2),
            leftImageView.heightAnchor.constraint(equalTo: leftImageView.widthAnchor),
            leftImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -2),
            
            rightImageView.topAnchor.constraint(equalTo: leftImageView.topAnchor),
            rightImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            rightImageView.widthAnchor.constraint(equalToConstant: (UIScreen.main.bounds.width / 2) - 2),
            rightImageView.heightAnchor.constraint(equalTo: rightImageView.widthAnchor)
        ])
    }
    
    private func setupTapRecognizers() {
        let leftImageRecognizer = UITapGestureRecognizer(target: self, action: #selector(leftImageTapped))
        leftImageView.addGestureRecognizer(leftImageRecognizer)
        let rightImageRecognizer = UITapGestureRecognizer(target: self, action: #selector(rightImageTapped))
        rightImageView.addGestureRecognizer(rightImageRecognizer)
    }
    
    @objc private func leftImageTapped() {
        self.onLeftImageTap?()
    }
    
    @objc private func rightImageTapped() {
        if viewModel?.rightImage != nil {
            self.onRightImageTap?()
        }
    }
}
