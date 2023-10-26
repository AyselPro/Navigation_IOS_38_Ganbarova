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

public class ViewController: UIViewController {
    
    lazy var box = UIView()
    
    private let ProfileHeaderView: UIView = {
        let view = UIView()
        view.backgroundColor = .red
        //1
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private func initialize() {
        
        let avatarImageView = UIImageView()
        avatarImageView.layer.borderColor = UIColor.white.cgColor
        avatarImageView.layer.borderWidth = 3
        avatarImageView.image = UIImage(named: "Image")
        avatarImageView.clipsToBounds = true
        view.addSubviews(avatarImageView)
        avatarImageView.snp.makeConstraints {maker in
            maker.leading.equalToSuperview().inset(16)
            maker.height.equalToSuperview().inset(100)
        }
        
        let fullNameLabel = UILabel()
        fullNameLabel.text = "Hipster Cat"
        fullNameLabel.font = .systemFont(ofSize: 18, weight: .bold)
        fullNameLabel.textColor = .black
        fullNameLabel.snp.makeConstraints { maker in
            maker.leading.equalToSuperview().inset(16)
            maker.top.equalTo(avatarImageView).inset(27)
        }
        
        let statusLabel = UILabel()
        statusLabel.text = "Waiting for something..."
        statusLabel.font = .systemFont(ofSize: 14, weight: .regular)
        statusLabel.textColor = .gray
        statusLabel.numberOfLines = 0
        statusLabel.snp.makeConstraints { maker in
            maker.leading.equalTo(avatarImageView).inset(16)
            maker.top.greaterThanOrEqualTo(fullNameLabel).inset(10)
        }
        
        let statusTextField = UITextField()
        statusTextField.borderStyle = .roundedRect
        statusTextField.placeholder = "Set your status..."
        statusTextField.snp.makeConstraints { maker in
            maker.top.equalTo(statusLabel).inset(5)
            maker.height.equalToSuperview().inset(34)
        }
        
        let setStatusButton = UIButton()
        setStatusButton.backgroundColor = .systemBlue
        setStatusButton.setTitleColor(UIColor.white, for: .normal)
        setStatusButton.setTitleColor(UIColor.red, for: .focused)
        setStatusButton.setTitleColor(UIColor.red, for: .highlighted)
        setStatusButton.setTitle("Set status", for: .normal)
        setStatusButton.layer.cornerRadius = 4
        setStatusButton.snp.makeConstraints { maker in
            maker.top.equalTo(statusTextField).inset(16)
            maker.leading.equalToSuperview().inset(16)
        }
        
        func viewDidLoad() {
            super.viewDidLoad()
            
            self.view.addSubview(box)
            box.snp.makeConstraints { (make) -> Void in
                make.width.height.equalTo(50)
                make.center.equalTo(self.view)
            }
        }
    }
    
}
