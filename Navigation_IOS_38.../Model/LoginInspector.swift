//
//  LoginInspector.swift
//  Navigation_IOS_38...
//
//   Created by Aysel on 04.12.2023.
//

import Foundation

class LoginInspector: LogInViewControllerDelegate {
    static var shared: LoginInspector = LoginInspector()
    private init() {}
    
    func check(login: String, password: String) -> Bool {
        return Checker.shared.check(login: login, password: password)
    }
}
