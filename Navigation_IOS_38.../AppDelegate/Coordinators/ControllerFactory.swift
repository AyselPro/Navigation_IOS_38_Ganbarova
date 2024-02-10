//
//  ControllerFactory.swift
//  Navigation_IOS_38...
//
//  Created by Aysel on 06.02.2024.
//

import UIKit

protocol ControllerFactory {
    var onClose: Action? { get set }
    var onNext: Action? { get set }
    
    func makeFeed() -> (viewModel: FeedVM, controller: FeedViewController)
}

class ControllerFactoryImpl: ControllerFactory {
    var onNext: Action?
    var onClose: Action?
    
    func makeFeed() -> (viewModel: FeedVM, controller: FeedViewController) {
        let viewModel = FeedVMImp()
        viewModel.onNext = onNext
        
        let controller = FeedViewController(viewModel: viewModel)
        return (viewModel, controller)
    }

}
