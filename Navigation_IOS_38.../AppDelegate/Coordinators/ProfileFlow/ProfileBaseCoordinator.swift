//
//  ProfileBaseCoordinator.swift
//  Navigation_IOS_38...
//
//  Created by Aysel on 11.12.2023.
//

import UIKit

class ProfileCoordinator: ProfileBaseCoordinator {
    
    var parentCoordinator: LoginBaseCoordinator?
    lazy var rootViewController: UIViewController = UIViewController()
    
    private var user: User
    
    // MARK: - Init
    init(user: User, viewModel: ProfileVM) {
        self.user = user
        // self.coordinator = coordinator
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func start() -> UIViewController {
        let viewModel = ProfileVMImp()
        viewModel.onDetail = { [ weak self ] in
            self?.showDetailScreen()
        }
        let module = ProfileViewController(
            //todo
         user: user, viewModel: viewModel
        )
        
        rootViewController = UINavigationController(
            rootViewController: module
            )
        return rootViewController
    }
    
    func showDetailScreen() {
        let viewModel = ProfileDetailVMImp()
        viewModel.onClose = { [weak self] in
            self?.parentCoordinator?.moveTo(flow: .feed)
        }
       // viewModel.onNext = {  [weak self] in
         //   self?.showNextScreen()
       // }
        let module = ProfileDetailVC(
            viewModel: viewModel
        )
        navigationRootViewController?.pushViewController(module, animated: true)
    }
    
    //func showNextScreen() {
      //  let viewModel = ProfileDetailVMImp()
     //   viewModel.onClose = { [weak self] in
     //       self?.parentCoordinator?.moveTo(flow: .feed)
     //   }
     //   let module = ProfileDetailVC(
      //      viewModel: viewModel
     //   )
    //    navigationRootViewController?.pushViewController(module, animated: true)
  //  }
    
    
}
