//
//  PostTableViewCell.swift
//  Navigation_IOS_38_Ganbarova
//
//  Created by Aysel on 05.10.2023.
//

import UIKit
import iOSIntPackage

final class PostTableViewCell: UITableViewCell {
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.backgroundColor = .clear
        return stackView
    }()
    
    private let footerStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 10
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.backgroundColor = .clear
        return stackView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.numberOfLines = 2
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .systemGray
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.numberOfLines = 0
        return label
    }()
    
    private let viewsLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.numberOfLines = 0
        label.textAlignment = .right
        return label
    }()
    
    private let likesLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.numberOfLines = 0
        return label
    }()
    
    private let avatarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .black
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private var actionOnDoubleTap: (() -> ())?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        let recogniser = UITapGestureRecognizer()
        recogniser.numberOfTouchesRequired = 2
        recogniser.addTarget(self, action: #selector(didDoubleTap))
        addGestureRecognizer(recogniser)
        
        setupView()
    }
    
    @objc private func didDoubleTap() {
        actionOnDoubleTap?()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        
        let titleView = UIView()
        titleView.backgroundColor = .clear
        titleView.addSubview(titleLabel)
        
        let descriptionView = UIView()
        descriptionView.backgroundColor = .clear
        descriptionView.addSubview(descriptionLabel)
        
        let footerView = UIView()
        footerView.backgroundColor = .clear
        footerView.addSubview(footerStackView)
        
        [footerStackView, descriptionLabel, titleLabel].forEach { view in
            view.translatesAutoresizingMaskIntoConstraints = false
        }
        
        contentView.addSubviews(stackView)
        footerStackView.addArrangedSubviews([likesLabel, viewsLabel])
        stackView.addArrangedSubviews([titleView, avatarImageView, descriptionView, footerView])
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            titleLabel.topAnchor.constraint(equalTo: titleView.topAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: titleView.bottomAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: titleView.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: titleView.trailingAnchor, constant: -16),

            descriptionLabel.topAnchor.constraint(equalTo: descriptionView.topAnchor),
            descriptionLabel.bottomAnchor.constraint(equalTo: descriptionView.bottomAnchor),
            descriptionLabel.leadingAnchor.constraint(equalTo: descriptionView.leadingAnchor, constant: 16),
            descriptionLabel.trailingAnchor.constraint(equalTo: descriptionView.trailingAnchor, constant: -16),

            footerStackView.topAnchor.constraint(equalTo: footerView.topAnchor),
            footerStackView.bottomAnchor.constraint(equalTo: footerView.bottomAnchor),
            footerStackView.leadingAnchor.constraint(equalTo: footerView.leadingAnchor, constant: 16),
            footerStackView.trailingAnchor.constraint(equalTo: footerView.trailingAnchor, constant: -16),
            
            avatarImageView.heightAnchor.constraint(equalTo: avatarImageView.widthAnchor, multiplier: 1)
        ])
    }
    
    func setupView(post: Post, actionOnDoubleTap: (() -> ())? = nil) {
        titleLabel.text = post.author
        avatarImageView.image = UIImage(named: post.image)
        descriptionLabel.text = post.description
        viewsLabel.text = "Views: " + String(post.views)
        likesLabel.text = "Likes: " + String(post.likes)
        self.actionOnDoubleTap = actionOnDoubleTap
        
        guard let image = UIImage(named: post.image) else { return }
        ImageProcessor().processImage(sourceImage: image, filter: .tonal) { image in
            avatarImageView.image = image
        }
        
    }
}


