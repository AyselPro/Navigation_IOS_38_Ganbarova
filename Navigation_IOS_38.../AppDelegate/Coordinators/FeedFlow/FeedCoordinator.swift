//
//  FeedCoordinator.swift
//  Navigation_IOS_38...
//
//  Created by Aysel on 11.12.2023.
//

import UIKit

class FeedCoordinator: FeedBaseCoordinator {
    
    var parentCoordinator: LoginBaseCoordinator?
    
    var rootViewController = UIViewController()
    
    let navigationController: UINavigationController
    
    init(navigation: UINavigationController) {
        self.navigationController = navigation
    }
    
    func start() -> UIViewController {
        let viewModel = FeedVMImp()
        viewModel.onNext = { [weak self] in
            self?.showDetailScreen()
        }
        let view = FeedViewController(viewModel: viewModel)
        viewModel.view = view
        
        navigationController.setViewControllers([rootViewController], animated: true)
        rootViewController = view
        
        return rootViewController
    }
    
    func showDetailScreen() {
        //todo-проверка
        // let vc = FeedDetailVC()
        //  navigationRootViewController?.pushViewController(vc, animated: true)
        // }
    }
    
}
