//
//  FeedViewController.swift
//  Navigation_IOS_38_Ganbarova
//
//  Created by Aysel on 05.10.2023.
//

import UIKit

class FeedViewController: UIViewController {
    
   private var post = Post(title: "Мой пост")
    
    private lazy var button: UIButton = {
        let button = UIButton()
        button.backgroundColor = .blue
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 12
        button.setTitle("Перейти на пост", for: .normal)
        button.setTitleColor(.lightGray, for: .normal)
        
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .lightGray

        self.view.addSubview(self.button)
        
        NSLayoutConstraint.activate([
            self.button.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -100
                                               ),
            self.button.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20
                                                ),
            self.button.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20
                                                 ),
            self.button.heightAnchor.constraint(equalToConstant: 50)
        ])
        
    }
    
    @objc func buttonAction(_ sender: UIButton) {
        let postViewController = PostViewController(post: post)
        postViewController.modalTransitionStyle = .flipHorizontal
        postViewController.modalPresentationStyle = .fullScreen
        
        self.navigationController?.pushViewController(postViewController, animated: true)
    }
        
}

   
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
    

