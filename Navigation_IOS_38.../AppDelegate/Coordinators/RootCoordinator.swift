//
//  RootCoordinator.swift
//  Navigation_IOS_38...
//
//  Created by Aysel on 06.02.2024.
//

import UIKit

class RootCoordinator: Coordinator {
    var coordinators: [Coordinator] = []
    var rootViewController: UIViewController
    var parentCoordinator: LoginBaseCoordinator?
    
    init() {
        let tabBarController = TabBarController()
        rootViewController = tabBarController
        
        let feedCoordinator = configureFeed()
        let loginCoordinator = configureLogin()
        coordinators.append(feedCoordinator)
        coordinators.append(loginCoordinator)
        
        tabBarController.viewControllers = [
            feedCoordinator.navigationController,
            loginCoordinator.navigationController
        ]
        
        _ = feedCoordinator.start()
        _ = loginCoordinator.start()
    }
    
    func start() -> UIViewController {
        let factory = ControllerFactoryImpl()
        factory.onNext = { }
        let (_, viewController) = factory.makeFeed()
        return viewController
    }
    
    private func configureFeed() -> FeedCoordinator {
        
        let navigationFirst = UINavigationController()
        navigationFirst.tabBarItem = UITabBarItem(
            title: "Feed",
            image: UIImage(systemName: "square.and.pencil"),
            selectedImage: nil)
        let coordinator = FeedCoordinator(navigation: navigationFirst)
        
        return coordinator
    }
    
    private func configureLogin() -> LoginCoordinator {
        
        let navigationSecond = UINavigationController()
        navigationSecond.tabBarItem = UITabBarItem(
            title: "Profile",
            image: UIImage(systemName: "person"),
            selectedImage: nil)
        let coordinator = LoginCoordinator(navigation: navigationSecond)
        
        return coordinator
    }
}
