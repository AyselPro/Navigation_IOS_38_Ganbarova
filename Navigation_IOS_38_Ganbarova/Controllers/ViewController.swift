//
//  ViewController.swift
//  Navigation_IOS_38_Ganbarova
//
//  Created by Aysel on 05.10.2023.
//

import UIKit
import StorageService
import SnapKit
import  iOSIntPackage

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
    }
    
    private func initialize() {
        view.backgroundColor = UIColor(red: 241/255, green: 238/255, blue: 228/255, alpha: 1)
        
        let avatarImageView = UIImageView()
        avatarImageView.layer.borderColor = UIColor.white.cgColor
        avatarImageView.layer.borderWidth = 3
        avatarImageView.image = UIImage(named: "Image")
        avatarImageView.clipsToBounds = true
        view.addSubview(avatarImageView)
        avatarImageView.snp.makeConstraints { maker in
            maker.top.equalToSuperview().inset(16)
            maker.leading.equalToSuperview ().inset(16)
            maker.width.equalToSuperview().inset(100)
            maker.height.equalToSuperview().inset(100)
        }
        
        let fullNameLabel = UILabel()
        fullNameLabel.text = "Hipster Cat"
        fullNameLabel.font = .systemFont(ofSize: 18, weight: .bold)
        fullNameLabel.textColor = .black
        view.addSubview(fullNameLabel)
        fullNameLabel.snp.makeConstraints { maker in
            maker.top.equalToSuperview().inset(27)
            maker.leading.equalTo(avatarImageView.trailingAnchor as! ConstraintRelatableTarget).inset(16)
            maker.trailing.equalToSuperview().inset(-16)
        }
        
        let statusLabel = UILabel()
        statusLabel.text = "Waiting for something..."
        statusLabel.font = .systemFont(ofSize: 14, weight: .regular)
        statusLabel.textColor = .gray
        statusLabel.numberOfLines = 0
        view.addSubview(statusLabel)
        statusLabel.snp.makeConstraints { maker in
            maker.top.greaterThanOrEqualTo(fullNameLabel.bottomAnchor as! ConstraintRelatableTarget).inset(10)
            maker.leading.equalTo(avatarImageView.trailingAnchor as! ConstraintRelatableTarget).inset(16)
            maker.trailing.equalToSuperview().inset(-16)
            maker.bottom.equalTo(avatarImageView)
        }
        
        let statusTextField = UITextField()
        statusTextField.borderStyle = .roundedRect
        statusTextField.placeholder = "Set your status..."
        view.addSubview(statusTextField)
        statusTextField.snp.makeConstraints { maker in
            maker.top.equalTo(statusLabel.bottomAnchor as! ConstraintRelatableTarget).inset(5)
            maker.leading.equalTo(statusLabel)
            maker.trailing.equalTo(statusLabel)
            maker.height.equalToSuperview().inset(34)
        }
        
        let setStatusButton = UIButton()
        setStatusButton.backgroundColor = .systemBlue
        setStatusButton.setTitleColor(UIColor.white, for: .normal)
        setStatusButton.setTitleColor(UIColor.red, for: .focused)
        setStatusButton.setTitleColor(UIColor.red, for: .highlighted)
        setStatusButton.setTitle("Set status", for: .normal)
        setStatusButton.layer.cornerRadius = 4
        view.addSubview(setStatusButton)
        setStatusButton.snp.makeConstraints { maker in
            maker.top.equalTo(statusTextField.bottomAnchor as! ConstraintRelatableTarget).inset(16)
            maker.leading.equalToSuperview().inset(16)
            maker.trailing.equalToSuperview().inset(-16)
            maker.bottom.equalToSuperview().inset(-10)
        }
            setStatusButton.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        }
    
        @objc private func buttonPressed () {
           
            
        }
    
}
