//
//  PostListViewController.swift
//  Navigation_IOS_38...
//
//  Created by Aysel on 28.12.2023.
//

import UIKit

final class PostListViewController: UIViewController {
    
    private let posts: [Post] = Post.posts
    private let postService: IPostService
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.register(PostTableViewCell.self, forCellReuseIdentifier: PostTableViewCell.identifier)
        tableView.allowsSelection = false
        return tableView
    }()
    
    init(postService: IPostService) {
        self.postService = postService
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Посты"
        tabBarItem.image = UIImage(systemName: "pencil.and.list.clipboard")
        view.backgroundColor = .white
        layout()
    }
    
    private func didDoubleTapPost(at indexPath: IndexPath) {
        let selectedPost = posts[indexPath.row]
        if postService.containsPost(id: selectedPost.id) {
            postService.deletePost(id: selectedPost.id)
        } else {
            postService.savePost(selectedPost)
        }
    }
    
    private func layout() {
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

extension PostListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: PostTableViewCell.identifier,
            for: indexPath
        ) as? PostTableViewCell else { return UITableViewCell() }
        
        let post = posts[indexPath.row]
        cell.setupView(
            post: post,
            actionOnDoubleTap: { [weak self] in
                self?.didDoubleTapPost(at: indexPath)
            }
        )
        return cell
    }
}
