//
//  UserDetailTableCell.swift
//  DummygramMVVM
//
//  Created by Bagas Ilham on 09/08/22.
//

import UIKit
import Kingfisher

final class UserDetailTableCell: UITableViewCell {
    
    var viewModel: UserDetailCellViewModel? {
        didSet {
            if let string = viewModel?.userImage, let url = URL(string: string) {
                userImageView.kf.indicatorType = .activity
                userImageView.kf.setImage(with: url, options: [.transition(.fade(0.2))])
            }
            if let firstName = viewModel?.firstName, let lastName = viewModel?.lastName {
                userNameLabel.text = firstName.lowercased() + lastName.lowercased()
                userFullNameLabel.text = "\(firstName) \(lastName)"
            }
            if let email = viewModel?.email {
                userEmailLabel.text = "✉️ \(email)"
            }
            if let birthday = viewModel?.dateOfBirth {
                userBirthdayLabel.text = "🎂 \(birthday)"
            }
            if let address = viewModel?.location {
                userAddressLabel.text = "🏠 \(address)"
            }
        }
    }
    
    var userImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 48
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    var userNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.numberOfLines = 1
        label.useAppFont(weight: .bold, size: 24)
        return label
    }()
    
    var userFullNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.numberOfLines = 1
        label.useAppFont(weight: .book, size: 16)
        return label
    }()
    
    var userEmailLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.useAppFont(weight: .book, size: 16)
        label.numberOfLines = 0
        return label
    }()
    
    var userBirthdayLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.useAppFont(weight: .book, size: 16)
        label.numberOfLines = 0
        return label
    }()
    
    var userAddressLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.useAppFont(weight: .book, size: 16)
        label.textColor = .secondaryLabel
        label.numberOfLines = 0
        return label
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
        contentView.addSubviews(userImageView, userNameLabel, userFullNameLabel, userEmailLabel, userBirthdayLabel, userAddressLabel)
        let margin = contentView.layoutMarginsGuide
        NSLayoutConstraint.activate([
            contentView.heightAnchor.constraint(greaterThanOrEqualToConstant: 10),
            
            userImageView.topAnchor.constraint(equalTo: margin.topAnchor),
            userImageView.centerXAnchor.constraint(equalTo: margin.centerXAnchor),
            userImageView.heightAnchor.constraint(equalToConstant: 96),
            userImageView.widthAnchor.constraint(equalTo: userImageView.heightAnchor),
            
            userNameLabel.topAnchor.constraint(equalTo: userImageView.bottomAnchor, constant: 8),
            userNameLabel.centerXAnchor.constraint(equalTo: userImageView.centerXAnchor),
            
            userFullNameLabel.topAnchor.constraint(equalTo: userNameLabel.bottomAnchor, constant: 2),
            userFullNameLabel.centerXAnchor.constraint(equalTo: userImageView.centerXAnchor),
            
            userEmailLabel.topAnchor.constraint(equalTo: userFullNameLabel.bottomAnchor, constant: 8),
            userEmailLabel.centerXAnchor.constraint(equalTo: userImageView.centerXAnchor),
            
            userBirthdayLabel.topAnchor.constraint(equalTo: userEmailLabel.bottomAnchor, constant: 2),
            userBirthdayLabel.centerXAnchor.constraint(equalTo: userImageView.centerXAnchor),
            
            userAddressLabel.topAnchor.constraint(equalTo: userBirthdayLabel.bottomAnchor, constant: 2),
            userAddressLabel.centerXAnchor.constraint(equalTo: userImageView.centerXAnchor),
            userAddressLabel.widthAnchor.constraint(equalTo: margin.widthAnchor),
            userAddressLabel.bottomAnchor.constraint(equalTo: margin.bottomAnchor)
        ])
    }
    
}
