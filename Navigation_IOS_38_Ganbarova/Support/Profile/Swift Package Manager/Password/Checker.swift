//
//  Checker.swift
//  Navigation_IOS_38_Ganbarova
//
//  Created by Aysel on 18.11.2023.
//

import Foundation

class Checker {
    
    static let shared = Checker()
    
    private let login: String = "SHA384"
    private let password: String = "{9Z!"
    
    private init() {
        
    }
    
    func check(loginPasswordAYSEL30 trierString: String, time: Date) -> Bool {
        
        let checkerString = (login + "\(time.hashValue)" + password).aysel30()
        
        if trierString == checkerString {
            return true
        } else {
            return false
        }
    }
    
}
