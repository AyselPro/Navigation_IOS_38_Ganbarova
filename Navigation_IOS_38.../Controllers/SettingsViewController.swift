//
//  SettingsViewController.swift
//  Navigation_IOS_38...
//
//  Created by Aysel on 30.12.2023.
//

import UIKit
import KeychainAccess

final class SettingsViewController: UIViewController {
    
    private let sortedSwitch = UISwitch()
    private let sortedSwitchTitle = UILabel()
    
    private let changePasswordButton = UIButton()
    
    private let keychainService: Keychain
    private let userDefaults: UserDefaults
    
    init(userDefaults: UserDefaults, keychainService: Keychain) {
        self.keychainService = keychainService
        self.userDefaults = userDefaults
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        sortedSwitchTitle.text = "Сортировка файлов по алфавиту"
        changePasswordButton.configuration = .borderedTinted()
        changePasswordButton.setTitle("Поменять пароль", for: .normal)
        
        sortedSwitch.isOn = userDefaults.bool(forKey: .isSortedKey)
        sortedSwitch.addTarget(self, action: #selector(switchDidChange), for: .valueChanged)
        changePasswordButton.addTarget(self, action: #selector(changePasswordButtonDidTap), for: .touchUpInside)
        
        view.addSubviews(sortedSwitch, sortedSwitchTitle, changePasswordButton)
        
        NSLayoutConstraint.activate([
            sortedSwitch.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            sortedSwitch.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            sortedSwitchTitle.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            sortedSwitchTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            sortedSwitchTitle.trailingAnchor.constraint(equalTo: sortedSwitch.leadingAnchor, constant: -20),
            
            changePasswordButton.topAnchor.constraint(equalTo: sortedSwitch.bottomAnchor, constant: 20),
            changePasswordButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    @objc private func switchDidChange() {
        userDefaults.set(sortedSwitch.isOn, forKey: .isSortedKey)
    }
    
    @objc private func changePasswordButtonDidTap() {
        keychainService[.passwordKey] = "999999"
    }
}
