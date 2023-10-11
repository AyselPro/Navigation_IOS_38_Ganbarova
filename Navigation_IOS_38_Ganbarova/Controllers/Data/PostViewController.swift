//
//  PostViewController.swift
//  Navigation_IOS_38_Ganbarova
//
//  Created by Aysel on 05.10.2023.
//

import UIKit

class PostViewController: UIViewController {
    
    init(post: Post) {
        super.init(nibName: nil, bundle: nil)
        self.post = post
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var post: Post!
    var titlePost: String {
        return post.title
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView() {
        view.backgroundColor = .lightGray
        navigationItem.title = titlePost
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Item", style: .done, target: self, action: #selector(tapBurButtonItamAction))
        view.backgroundColor = .white
    }
    
    @objc private func tapBurButtonItamAction() {
        let vc = InfoViewController()
        present(vc, animated: true)
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
