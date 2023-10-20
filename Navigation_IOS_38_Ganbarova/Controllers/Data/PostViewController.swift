//
//  PostViewController.swift
//  Navigation_IOS_38_Ganbarova
//
//  Created by Aysel on 05.10.2023.
//

import UIKit

class PostViewController: UIViewController {
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView() {
        view.backgroundColor = .lightGray
       
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Item", style: .done, target: self, action: #selector(tapBurButtonItamAction))
        view.backgroundColor = .white
    }
    
    @objc private func tapBurButtonItamAction() {
        let vc = InfoViewController()
        present(vc, animated: true)
    }
    
    
}
