//
//  PasswordUserController.swift
//  Navigation_IOS_38...
//
//  Created by Aysel on 26.01.2024.
//

import UIKit

class PasswordUserController: UIViewController {
    
    private let passwordTextField = UITextField()
    private let generatedPasswordLabel = UILabel()
    private let generatePasswordButton = UIButton()
    private let activityIndicator = UIActivityIndicatorView()
    
    private var isBruteForcing: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        generatedPasswordLabel.textAlignment = .center
        generatedPasswordLabel.text = "Пароль не сгенерирован"
        
        generatePasswordButton.configuration = .bordered()
        generatePasswordButton.setTitle("Подобрать пароль", for: .normal)
        generatePasswordButton.addTarget(self, action: #selector(onGeneratePasswordButtonTap), for: .touchUpInside)
        
        passwordTextField.borderStyle = .roundedRect
        
        view.backgroundColor = .white
        view.addSubviews(
            generatePasswordButton,
            generatedPasswordLabel,
            activityIndicator,
            passwordTextField
        )
        setupLayout()
    }
    
    @objc
    private func onGeneratePasswordButtonTap() {
        guard !isBruteForcing else { return }
        
        let allowedCharacters: [String] = String().printable.map { String($0) }
        
        var password = ""
        for _ in 0...2 {
            let index = Int.random(in: 0..<allowedCharacters.count)
            password.append(allowedCharacters[index])
        }
        
        generatedPasswordLabel.text = password
        
        activityIndicator.startAnimating()
        self.activityIndicator.isHidden = false
        isBruteForcing = true
        
        DispatchQueue.global().async { [weak self] in
            guard let self else { return }
            self.bruteForce(passwordToUnlock: password) { bruteForcedPassword in
                self.isBruteForcing = false
                DispatchQueue.main.async {
                    self.activityIndicator.stopAnimating()
                    self.passwordTextField.text = bruteForcedPassword
                    self.passwordTextField.isSecureTextEntry = false
                    self.activityIndicator.isHidden = true
                }
            }
        }
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate(
            [
                generatePasswordButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                generatePasswordButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5),
                generatePasswordButton.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 50),
                
                generatedPasswordLabel.bottomAnchor.constraint(equalTo: generatePasswordButton.topAnchor, constant: -20),
                generatedPasswordLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
                generatedPasswordLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
                
                activityIndicator.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
                activityIndicator.centerYAnchor.constraint(equalTo: passwordTextField.centerYAnchor),
                
                passwordTextField.topAnchor.constraint(equalTo: generatePasswordButton.bottomAnchor, constant: 20),
                passwordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
                passwordTextField.trailingAnchor.constraint(equalTo: activityIndicator.leadingAnchor, constant: -20),
                
            ]
        )
    }
    
    private func bruteForce(passwordToUnlock: String, completion: (String) -> ()) {
        let ALLOWED_CHARACTERS: [String] = String().printable.map { String($0) }
        
        var password: String = ""
        
        while password != passwordToUnlock {
            password = generateBruteForce(password, fromArray: ALLOWED_CHARACTERS)
        }
        
        completion(password)
    }
}

extension String {
    var digits:      String { return "0123456789" }
    var lowercase:   String { return "abcdefghijklmnopqrstuvwxyz" }
    var uppercase:   String { return "ABCDEFGHIJKLMNOPQRSTUVWXYZ" }
    var punctuation: String { return "!\"#$%&'()*+,-./:;<=>?@[\\]^_`{|}~" }
    var letters:     String { return lowercase + uppercase }
    var printable:   String { return digits + letters + punctuation }
    
    mutating func replace(at index: Int, with character: Character) {
        var stringArray = Array(self)
        stringArray[index] = character
        self = String(stringArray)
    }
}

func indexOf(character: Character, _ array: [String]) -> Int {
    return array.firstIndex(of: String(character))!
}

func characterAt(index: Int, _ array: [String]) -> Character {
    return index < array.count ? Character(array[index])
    : Character("")
}

func generateBruteForce(_ string: String, fromArray array: [String]) -> String {
    var str: String = string
    
    if str.count <= 0 {
        str.append(characterAt(index: 0, array))
    }
    else {
        str.replace(at: str.count - 1,
                    with: characterAt(index: (indexOf(character: str.last!, array) + 1) % array.count, array))
        
        if indexOf(character: str.last!, array) == 0 {
            str = String(generateBruteForce(String(str.dropLast()), fromArray: array)) + String(str.last!)
        }
    }
    
    return str
}

