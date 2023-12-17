//
//  FeedViewModel.swift
//  Navigation_IOS_38...
//
//  Created by Aysel on 08.12.2023.
//

import Foundation

protocol FeedViewOutput {
    var onTapShowFunnyPicture: () -> Void { get }
    var onTapShowNFTCollection: () -> Void { get }
    var onTapShowMedia: () -> Void { get }
}


class FeedViewModel: FeedViewOutput {
    
    var onShowFunnyPicture: (() -> Void)?
    
    lazy var onTapShowFunnyPicture: () -> Void = { [weak self] in
        self?.onShowFunnyPicture?()
    }
    
    var onShowNFTCollection: (() -> Void)?
   
    lazy var onTapShowNFTCollection: () -> Void = { [weak self] in
        self?.onShowNFTCollection?()
    }
    
    var onShowMedia: (() -> Void)?
        
    lazy var onTapShowMedia: () -> Void = { [weak self] in
        self?.onShowMedia?()
    }
    
    init() {}
}


func makeFeed() -> (viewModel: FeedModel, controller: FeedViewController) {
    let viewModel = FeedModel()
    let controller = FeedViewController(viewModel: viewModel as! FeedVM)
    return (viewModel, controller)
}
