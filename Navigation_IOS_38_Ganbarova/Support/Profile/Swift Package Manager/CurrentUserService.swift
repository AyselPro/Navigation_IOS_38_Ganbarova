//
//  CurrentUserService.swift
//  Navigation_IOS_38_Ganbarova
//
//  Created by Aysel on 16.11.2023.
//

import UIKit

class CurrentUserService: UserService {
    
    let currentUser = User(userLogin: "Aysel1994", userName: "Aysel", userAvatar: #imageLiteral(resourceName: "cat"))

    func currentUser(userLogin: String) throws -> User {
        
        if userLogin == currentUser.userLogin {
            return currentUser
        } else {
            throw LoginError.serverError
        }
    }
    
}
