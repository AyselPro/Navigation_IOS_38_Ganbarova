//
//  Checker.swift
//  Navigation_IOS_38...
//
//  Created by Aysel on 26.11.2023.
//

import Foundation

class Checker {
    //класс-это ссылочный тип, мы создаем delegate- образуем связь сильных ссылок между классами.(weak)
    
    static let shared = Checker()
    
    private let login: String = "Aysel1994"
    private let password: String = "{9Z!"
    
    private init() {
        
    }
    
    func check(login: String, password: String) -> Bool {
        login == self.login && password == self.password
        
    }
}
