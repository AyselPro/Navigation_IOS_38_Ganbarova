//
//  User.swift
//  Navigation_IOS_38_Ganbarova
//
//  Created by Aysel on 16.11.2023.
//

import UIKit

protocol UserService {
    
    func currentUser(userLogin: String) throws -> User
}

class User {
    
    internal let userLogin: String
    internal let userName: String
    internal var userAvatar: UIImage
    
    init(userLogin: String,
         userName: String,
         userAvatar: UIImage) {
        
        self.userLogin = userLogin
        self.userName = userName
        self.userAvatar = userAvatar
    }
}
