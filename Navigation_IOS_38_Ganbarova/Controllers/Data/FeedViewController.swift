//
//  FeedViewController.swift
//  Navigation_IOS_38_Ganbarova
//
//  Created by Aysel on 05.10.2023.
//

import UIKit

class FeedViewController: UIViewController {
    
    private var post = Post(title: "Мой пост")
    private let stackView: UIStackView = UIStackView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        stackView.axis = .vertical
        view.backgroundColor = .lightGray
        view.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
        
        let firstButton = UIButton()
        let secondButton = UIButton()
        
        firstButton.setTitle("Первая кнопка", for: .normal)
        secondButton.setTitle("Вторая кнопка", for: .normal)
        
        stackView.addArrangedSubview(firstButton)
        stackView.addArrangedSubview(secondButton)
        stackView.spacing = 10
        
        firstButton.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        secondButton.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
    }
    
    @objc private func buttonAction() {
        let postViewController = PostViewController(post: post)
        
        //1
        self.navigationController?.pushViewController(postViewController, animated: true)
        
        //2
//        postViewController.modalTransitionStyle = .flipHorizontal
//        postViewController.modalPresentationStyle = .fullScreen
//        present(postViewController, animated: true)
    }
}


