//
//  CurrentUserService.swift
//  Navigation_IOS_38_Ganbarova
//
//  Created by Aysel on 16.11.2023.
//

import Foundation

class CurrentUserService: UserService {
    var user: User = .init()
    
    func privateEntranceSystem(login: String) -> User? {
        guard login == self.user.login else { return nil }
        return user
    }
}
