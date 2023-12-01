//
//  LogInViewController.swift
//  Navigation_IOS_38_Ganbarova
//
//  Created by Aysel on 17.10.2023.
//

import UIKit

protocol LogInViewControllerDelegate: AnyObject {
    
    func check(login: String, password: String) -> Bool
    
    }

class LogInViewController: UIViewController {
    
    weak var delegate: LogInViewControllerDelegate?
    
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
        stackView.layer.cornerRadius = 10
        stackView.layer.masksToBounds = true
        stackView.layer.borderWidth = 0.5
        view.clipsToBounds = true
        
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
    
    // MARK: - Login View Content
    // Logo Image
    private let logoImageView: UIImageView = {
        let logo = UIImageView()
        logo.image = #imageLiteral(resourceName: "Logo")
        
        logo.translatesAutoresizingMaskIntoConstraints = false
        return logo
    }()
    
    // Brute Force Button
    private var passwordHackingButton: UIButton  = {
        
        let button = UIButton()
        button.setTitle("Guess the password", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .purple
        button.setTitleColor(.darkGray, for: .selected)
        button.setTitleColor(.darkGray, for: .highlighted)
        
        return button
    }()
    //
    @objc private func buttonAction() {
        guard let login = emailTextField.text, !login.isEmpty else { return }
        
        let service = CurrentUserService.shared
        
        guard let user = service.currentUser(login: login) else {
            errorAuth()
            return
        }
        
        let profileViewController = ProfileViewController(user: user)
        
        self.navigationController?.pushViewController(profileViewController, animated: true)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupConstraints()
        addSubViews()
        logInButtonSuccessed()
        
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
    
    private func errorAuth() {
        let alert = UIAlertController(title: "Ошибка авторизации", message: "введён корректный логин", preferredStyle: .alert)
        
        let ok = UIAlertAction(title: "Закрыть", style: .cancel)
        
        alert.addAction(ok)
        present(alert, animated: true)
    }
    
    private func errorCatched(error : String, errorMessage: String) {
        DispatchQueue.main.async {
            let alertController = UIAlertController(title: error, message: errorMessage, preferredStyle: .alert)
            let okAction = UIAlertAction(title: "ОК...", style: .default) { _ in
                print(error)
            }
            alertController.addAction(okAction)
            
        }
    }
    
    // MARK: Log In Logic
    private func logInButtonSuccessed() {
        
        let typedLogin = emailTextField.text
        let typedPassword = passwordTextField.text ?? ""
#if DEBUG
        var userService = TestUserService()
#else
        let userService = CurrentUserService()
        
        if let existingUserLogin = typedLogin {
            let profileViewController = ProfileViewController(userService: userService, typedLogin: existingUserLogin)
            do {
                let currentUser = try userService.currentUser(login: existingUserLogin)
                
                if currentUser.avatar != UIImage() {
                    
                    let currentMoment = Date()
                    guard let checkedLogin = typedLogin else {
                        preconditionFailure()
                    }
                    
                    let typedInfo = checkedLogin + "\(currentMoment.hashValue)" + typedPassword
                    
                    if checkMyPass(typedInfo, time: currentMoment) {
                        navigationController?.pushViewController(profileViewController, animated: true)
                        return
                    }
                    
                    DispatchQueue.main.async {
                        let alertController = UIAlertController(title: "Неверный пароль", message: "Побробуйте ещё раз", preferredStyle: .alert)
                        let okAction = UIAlertAction(title: "ОК", style: .default) { _ in
                            print("Wrong password")
                        }
                        
                        alertController.addAction(okAction)
                        
                        self.present(alertController, animated: true, completion: nil)
                    }
                }
            } catch let error {
                let error = "User not found on the server"
                self.errorCatched(error: error, errorMessage: "Something went wrong on the server side. Please, try to log in again")
            } catch {
                let error = "Unknown error"
                self.errorCatched(error: error, errorMessage: "Something went wrong. Please, reload the app")
            }
            
        }
#endif
    }
}

extension LogInViewController: LogInViewControllerDelegate {
    func check(login: String, password: String) -> Bool {
        return Checker.shared.check(login: "Aysel1994", password: "{9Z!")
    }
}

class LoginInspector: LogInViewControllerDelegate {
    func check(login: String, password: String) -> Bool {
        return Checker.shared.check(login: "Aysel1994", password: "{9Z!")
    }
}

    protocol LogInFactory {
        func setLogInInspector() -> LoginInspector
        
    }
    
    struct MyLogInFactory: LogInFactory {
        
        private let inspector = LoginInspector()
        
        func setLogInInspector() -> LoginInspector {
            return inspector
        }
   }

extension UIView {
    func addSubview(_ views: UIView...) {
        views.forEach { addSubview($0) }
    }
}
