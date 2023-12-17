//
//  ProfileHeaderView.swift
//  Navigation_IOS_38_Ganbarova
//
//  Created by Aysel on 05.10.2023.
//

import UIKit

final class ProfileHeaderView: UIView {
    private let avatarImageView = UIImageView()
    private let fullNameLabel = UILabel()
    private let statusLabel = UILabel()
    private lazy var setStatusButton = CustomButton(titleText: "Set status", titleColor: UIColor.white, backgroundColor: .systemBlue, tapAction: buttonPressed)
    private let statusTextField = UITextField()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .lightGray
        setupView()
        setupConstraint()
        setupShadow()
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupCornerRadius()
    }
    
    private func setupCornerRadius() {
        let height = avatarImageView.frame.height / 2
        avatarImageView.layer.cornerRadius = height
    }
    
    
    private func setupShadow() {
        let newColor = UIColor.black
        setStatusButton.layer.shadowColor = newColor.cgColor
        setStatusButton.layer.masksToBounds = true
        setStatusButton.clipsToBounds = false
        setStatusButton.layer.shadowOffset = CGSize(width: 4, height: 4)
        setStatusButton.layer.shadowRadius = 4
        setStatusButton.layer.shadowOpacity = 0.7
    }
    
    @objc private func buttonPressed() {
        let text = statusTextField.text ?? ""
        print(text)
    }
    
    
    private func setupView() {
        self.addSubviews(avatarImageView, fullNameLabel, statusLabel, statusTextField, setStatusButton)
        
        avatarImageView.layer.borderColor = UIColor.white.cgColor
        avatarImageView.layer.borderWidth = 3
        avatarImageView.image = UIImage(named: "Image")
        avatarImageView.clipsToBounds = true
        
        fullNameLabel.text = "Hipster Cat"
        fullNameLabel.font = .systemFont(ofSize: 18, weight: .bold)
        fullNameLabel.textColor = .black
        
        statusLabel.text = "Waiting for something..."
        statusLabel.font = .systemFont(ofSize: 14, weight: .regular)
        statusLabel.textColor = .gray
        statusLabel.numberOfLines = 0
        
        setStatusButton.setTitleColor(UIColor.red, for: .focused)
        setStatusButton.setTitleColor(UIColor.red, for: .highlighted)
        setStatusButton.layer.cornerRadius = 4
        
        statusTextField.borderStyle = .roundedRect
        statusTextField.placeholder = "Set your status..."
    }
        
    private func setupConstraint() {
        
        NSLayoutConstraint.activate([
            avatarImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 16),
            avatarImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            avatarImageView.widthAnchor.constraint(equalToConstant: 100),
            avatarImageView.heightAnchor.constraint(equalToConstant: 100),
        
            fullNameLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 27),
            fullNameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 16),
            fullNameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
        
            statusLabel.topAnchor.constraint(greaterThanOrEqualTo: fullNameLabel.bottomAnchor, constant: 10),
            statusLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 16),
            statusLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            statusLabel.bottomAnchor.constraint(equalTo: avatarImageView.bottomAnchor),
            
            statusTextField.topAnchor.constraint(equalTo: statusLabel.bottomAnchor, constant: 5),
            statusTextField.leadingAnchor.constraint(equalTo: statusLabel.leadingAnchor),
            statusTextField.trailingAnchor.constraint(equalTo: statusLabel.trailingAnchor),
            statusTextField.heightAnchor.constraint(equalToConstant: 34),
        
            setStatusButton.topAnchor.constraint(equalTo: statusTextField.bottomAnchor, constant: 16),
            setStatusButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            setStatusButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            setStatusButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10)
        ])
    }
}
