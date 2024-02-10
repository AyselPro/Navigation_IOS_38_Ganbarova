//
//  ControllerDetailVC.swift
//  Navigation_IOS_38...
//
//  Created by Aysel on 07.02.2024.
//

import UIKit

class ControllerDetailVC: UIViewController {
    
    let viewModel: ControllerFactory
    
    init(viewModel: ControllerFactory) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view?.backgroundColor = .systemPurple
        
    }
}
