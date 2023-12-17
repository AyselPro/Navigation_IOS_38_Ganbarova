//
//  LoginCoordinator.swift
//  Navigation_IOS_38...
//
//  Created by Aysel on 11.12.2023.
//

import UIKit

enum AppFlow {
    case profile
    case feed
}

class LoginCoordinator: LoginBaseCoordinator {
  
    var parentCoordinator: LoginBaseCoordinator?
    
    lazy var profileCoordinator: ProfileBaseCoordinator = ProfileCoordinator.init(user: .init(login: "dsfs", firstName: "", avatar: UIImage(), status: ""), viewModel:ProfileVMImp())
    lazy var feedCoordinator: FeedBaseCoordinator = FeedCoordinator()

    lazy var rootViewController: UIViewController  = UITabBarController()
    
    func start() -> UIViewController {
        let profileViewController = profileCoordinator.start()
        profileCoordinator.parentCoordinator = self
        profileViewController.tabBarItem = UITabBarItem(
        title: "Профиль",
        image: UIImage(systemName: "person.circle"),
        tag: 0
        )
        
        let feedViewController = feedCoordinator.start()
        feedCoordinator.parentCoordinator = self
        feedViewController.tabBarItem = UITabBarItem(
            title: "Лента",
            image: UIImage(systemName: "doc.richtext"),
            tag: 1
        )
        
        (rootViewController as? UITabBarController)?.viewControllers =
        [feedViewController, profileViewController]
        
        return rootViewController
    }
    
    func moveTo(flow: AppFlow) {
        switch flow {
        case.profile:
            (rootViewController as? UITabBarController)?.selectedIndex = 0
        case.feed:
            (rootViewController as? UITabBarController)?.selectedIndex = 1
        }
    }
    
    func resetToRoot() -> Self {
        profileCoordinator.resetToRoot()
        moveTo(flow: .profile)
        return self
    }
    
}
