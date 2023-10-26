//
//  LogInViewController.swift
//  Navigation_IOS_38_Ganbarova
//
//  Created by Aysel on 17.10.2023.
//

import UIKit

class LogInViewController: UIViewController {
    private let emailTextField: UITextField = {
        let textField = UITextField()
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.layer.borderWidth = 0.5
        textField.layer.cornerRadius = 10
        textField.textColor = .black
        textField.font = .systemFont(ofSize: 16, weight: .regular)
        textField.autocapitalizationType = .none
        textField.backgroundColor = .systemGray6
        textField.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        textField.placeholder = "Email of phone"
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        textField.leftViewMode = .always
        
        return textField
    }()
    
    private let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.layer.borderWidth = 0.5
        textField.layer.cornerRadius = 10
        textField.textColor = .black
        textField.font = .systemFont(ofSize: 16, weight: .regular)
        textField.autocapitalizationType = .none
        textField.backgroundColor = .systemGray6
        textField.isSecureTextEntry = true
        textField.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        textField.placeholder = "Password"
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        textField.leftViewMode = .always
        
        return textField
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [emailTextField, passwordTextField])
        stackView.axis = .vertical
        stackView.spacing = 0
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.backgroundColor = .clear
        
        return stackView
    }()
    
    private lazy var button: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 10
        button.setTitle("Log In", for: .normal)
        button.setTitleColor(.white, for: .normal)
        
        button.setTitleColor(.white.withAlphaComponent(0.8), for: .selected)
        button.setTitleColor(.white.withAlphaComponent(0.8), for: .highlighted)
        button.setTitleColor(.white.withAlphaComponent(0.8), for: .disabled)
        
        //
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    //
    @objc private func buttonAction() {
        
        let profileViewController = ProfileViewController()
        
        self.navigationController?.pushViewController(profileViewController, animated: true)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupConstraints()
        addSubViews()
        
    }
    
    private func setupConstraints() {
        let content = UIView()
        let scrollView = UIScrollView()
        let contentView = UIView()
        
        let safeAreaGuide = view.safeAreaLayoutGuide
        let imageView = UIImageView(image: .init(named: "Logo"))
        
        view.addSubviews(content)
        content.addSubviews(scrollView)
        scrollView.addSubviews(contentView)
        contentView.addSubviews(imageView, stackView, button)
        
        NSLayoutConstraint.activate([
            content.topAnchor.constraint(equalTo: safeAreaGuide.topAnchor),
            content.bottomAnchor.constraint(equalTo: safeAreaGuide.bottomAnchor),
            content.leadingAnchor.constraint(equalTo: safeAreaGuide.leadingAnchor),
            content.trailingAnchor.constraint(equalTo: safeAreaGuide.trailingAnchor),

            scrollView.topAnchor.constraint(equalTo: content.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: content.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: content.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: content.trailingAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, multiplier: 1),
            
            imageView.heightAnchor.constraint(equalToConstant: 100),
            imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor, multiplier: 1),
            imageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 120),

            stackView.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 120),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            stackView.heightAnchor.constraint(equalToConstant: 100),
            
            passwordTextField.heightAnchor.constraint(equalToConstant: 120),

            button.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 16),
            button.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -50),
            button.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            button.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            button.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    
    private func addSubViews() {
        navigationController?.navigationBar.isHidden = true
        view.backgroundColor = .white
        button.backgroundColor = UIColor(named: "Blue")
//        button.backgroundColor = "#4885CC".hexColor()
    }
}

