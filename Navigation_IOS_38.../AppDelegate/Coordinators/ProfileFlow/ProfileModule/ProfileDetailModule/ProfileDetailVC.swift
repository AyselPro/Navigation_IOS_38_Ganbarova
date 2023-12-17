//
//  ProfileDetailVC.swift
//  Navigation_IOS_38...
//
//  Created by Aysel on 11.12.2023.
//

import UIKit

class ProfileDetailVC: UIViewController {
    
    let viewModel: ProfileDetailVM
    
    private lazy var goToFavoriteButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("Go to profile tab", for: .normal)
        btn.layer.borderColor = UIColor.black.cgColor
        btn.layer.borderWidth = 2
        btn.backgroundColor = .black
        btn.addTarget(self, action: #selector(goToProfileTab), for: .touchUpInside)
        
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    init(viewModel: ProfileDetailVM) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        title = "Detail Profile"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        view.addSubviews(goToFavoriteButton)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view?.backgroundColor = .systemOrange
        setupUI()
    }
    
    @objc private func goToProfileTab() {
        
    }
    
}
