//
//  User.swift
//  Navigation_IOS_38_Ganbarova
//
//  Created by Aysel on 16.11.2023.
//

import UIKit

class User {
    var login: String = "aysel"
    var fullName: String = "Айсель"
    var status: String = "online"
    var avatar: UIImage! = UIImage(named: "image-2")
}

protocol UserService {
    func privateEntranceSystem(login: String) -> User?
}
