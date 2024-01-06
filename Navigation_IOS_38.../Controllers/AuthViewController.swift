//
//  AuthViewController.swift
//  Navigation_IOS_38_Ganbarova
//
//  Created by Aysel on 17.10.2023.
//

import UIKit
import KeychainAccess

protocol AuthViewControllerDelegate: AnyObject {
    func flowDidFinish()
}

final class AuthViewController: UIViewController {
    
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
        textField.placeholder = "Password"
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        textField.leftViewMode = .always
        
        return textField
    }()
    
    private lazy var logInButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 10
        button.setTitleColor(.white, for: .normal)
        
        button.backgroundColor = UIColor(named: "Blue")
        button.setTitleColor(.white.withAlphaComponent(0.8), for: .selected)
        button.setTitleColor(.white.withAlphaComponent(0.8), for: .highlighted)
        button.setTitleColor(.white.withAlphaComponent(0.8), for: .disabled)

        button.addTarget(self, action: #selector(logInButtonDidTap), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    private let logoImageView: UIImageView = {
        let logo = UIImageView()
        logo.image = #imageLiteral(resourceName: "Logo")
        
        logo.translatesAutoresizingMaskIntoConstraints = false
        return logo
    }()
    
    private var previousEnteredPassword: String?
    
    private let keychainService: Keychain
    private weak var delegate: AuthViewControllerDelegate?
    
    private var isPasswordSaved: Bool {
        keychainService[.passwordKey] != nil
    }
    
    init(
        delegate: AuthViewControllerDelegate,
        keychainService: Keychain
    ) {
        self.delegate = delegate
        self.keychainService = keychainService
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.loadView()
        
        view.backgroundColor = .white
        navigationController?.navigationBar.isHidden = true
        
        setupConstraints()
        updateButtonTitle()
        title = "Profile"
    }
    
    @objc private func logInButtonDidTap() {
        guard
            let password = passwordTextField.text,
            !password.isEmpty
        else {
            return showAlert(title: "Ошибка!", message: "Не введены поля")
        }
    
        if isPasswordSaved {
            guard let savedPassword = keychainService[.passwordKey] else {
                return showAlert(title: "Ошибка!", message: "Отсутсвует пароль")
            }
            guard password == savedPassword else {
                return showAlert(title: "Ошибка!", message: "Пароли не совпадают")
            }
            delegate?.flowDidFinish()
        } else {
            if let previousEnteredPassword {
                self.previousEnteredPassword = nil
                updateButtonTitle()
                guard password == previousEnteredPassword else {
                    passwordTextField.text = nil
                    return showAlert(title: "Ошибка!", message: "Пароли не совпадают")
                }
                keychainService[.passwordKey] = password
                delegate?.flowDidFinish()
            } else {
                guard password.count >= 4 else {
                    return showAlert(title: "Ошибка!", message: "Пароли должен содержать хотя бы 4 символа")
                }
                previousEnteredPassword = password
                updateButtonTitle()
            }
        }
        passwordTextField.text = nil
    }
    
    private func updateButtonTitle() {
        guard previousEnteredPassword == nil else {
            return logInButton.setTitle("Повторите пароль", for: .normal)
        }
        
        logInButton.setTitle(
            isPasswordSaved ? "Введите пароль" : "Создать пароль",
            for: .normal
        )
    }
    
    private func setupConstraints() {
        let safeAreaGuide = view.safeAreaLayoutGuide
        let imageView = UIImageView(image: .init(named: "Logo"))
        
        view.addSubviews(imageView, passwordTextField, logInButton)
        
        NSLayoutConstraint.activate([
            imageView.heightAnchor.constraint(equalToConstant: 100),
            imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor, multiplier: 1),
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 120),
            
            passwordTextField.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 120),
            passwordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            passwordTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            passwordTextField.heightAnchor.constraint(equalToConstant: 50),
            
            logInButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 16),
            logInButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            logInButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            logInButton.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
    
    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "Закрыть", style: .cancel)
        
        alert.addAction(ok)
        
        present(alert, animated: true)
    }
}
