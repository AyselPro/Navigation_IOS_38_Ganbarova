//
//  TestUserServicele.swift
//  Navigation_IOS_38_Ganbarova
//
//  Created by Aysel on 17.11.2023.
//

import UIKit

class TestUserService: UserService {
    
    let testUser = User(userLogin: "Aysel1994", userName: "Aysel", userAvatar: #imageLiteral(resourceName: "test_avatar"))
    
    func currentUser(userLogin: String) throws -> User {
        
        return testUser
    }
    
}

