//
//  PhotosTableViewCell.swift
//  Navigation_IOS_38_Ganbarova
//
//  Created by Aysel on 05.10.2023.
//

import UIKit

final class PhotosTableViewCell: UITableViewCell {
    private var imageViews = [UIImageView]()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCellEndConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView(images: [String]) {
        let count = images.count
        for (row, value) in imageViews.enumerated() {
            if count > row {
                let name = images[row]
                value.image = UIImage(named: name)
            } else {
                break
            }
        }
    }
    
    
    private func setupCellEndConstraints() {
        
        //Label
        let label = UILabel()
        label.text = "Photos"
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.textColor = .black
        
        let chevron = UIImage(systemName: "arrow.right")
        let chevronImageView = UIImageView(image: chevron)
        chevronImageView.tintColor = .black
        
        for _ in 1...4 {
            let imageView = UIImageView()
            imageView.backgroundColor = .clear
            imageView.clipsToBounds = true
            imageView.layer.cornerRadius = 6
            imageView.contentMode = .scaleAspectFill
            imageViews.append(imageView)
        }
        
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.addArrangedSubviews(imageViews)
        
        contentView.addSubviews(label, chevronImageView, stackView)
        
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),

            chevronImageView.centerYAnchor.constraint(equalTo: label.centerYAnchor),
            chevronImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),

            stackView.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 12),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            stackView.heightAnchor.constraint(equalToConstant: 100),
        ])
    }
}

