//
//  ProfileViewController.swift
//  Navigation_IOS_38_Ganbarova
//
//  Created by Aysel on 05.10.2023.
//

import UIKit
import StorageService
import iOSIntPackage

class ProfileViewController: UIViewController {
    
    private let profileHeaderView: ProfileHeaderView = ProfileHeaderView()
    private var posts = Post.posts
    
    private var userNotLoggedInMark = true
    private var animationWasShownMark = true
    private let reusedID = "cellID"
    
    //TODO: отобразить
    private var user: User
    private var login: String { return user.login }
    
    private lazy var tableView = UITableView(frame: view.bounds, style: .grouped)
    
    var collection: [UIImage] = []
    
    private lazy var avatarImageView: UIImageView = {
        let avatarImageView = UIImageView()
        avatarImageView.contentMode = .scaleAspectFill
        avatarImageView.clipsToBounds = true
        
        avatarImageView.layer.borderWidth = 3
        avatarImageView.layer.borderColor = UIColor.white.cgColor
        avatarImageView.alpha = 0
        
        avatarImageView.isUserInteractionEnabled = true
        avatarImageView.translatesAutoresizingMaskIntoConstraints = false
        
        return avatarImageView
    }()
    
    
    
    // MARK: - Init
    init(user: User) {
        self.user = user
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    // MARK: - Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.avatarImageView.image = user.avatar
        view.backgroundColor = .lightGray
        setupTableView()
        
        //TODO: установить таблицу по констрейнтам
        setupConstraints()
        
        navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        avatarImageView.layer.cornerRadius = view.bounds.width * 0.3 / 2
        
    }
    
    private func setupTableView() {
        navigationController?.tabBarController?.tabBar.isHidden = false
        navigationController?.navigationBar.isHidden = true
        
        tableView.register(PostTableViewCell.self, forCellReuseIdentifier: PostTableViewCell.identifier)
        tableView.separatorStyle = .singleLine
        tableView.separatorInset.right = 15
        tableView.dataSource = self
        tableView.delegate = self
        tableView.allowsSelection = false
    }
    
    private func setupConstraints() {
        //TODO: Добавить таблицу и установить констрейнты
        view.addSubviews(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }
}


extension ProfileViewController: UITableViewDataSource, UITableViewDelegate {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0: return 0
        default: return posts.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0: return UITableViewCell()
            
        default:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: PostTableViewCell.identifier, for: indexPath) as? PostTableViewCell else { return UITableViewCell()}
            let post = posts[indexPath.row]
            cell.setupView(post: post)
            return cell
        }
    }
    
    //MARK: UITableViewDataSource and UITableViewDelegate
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let profileHeaderView = self.profileHeaderView
        
        return profileHeaderView
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (indexPath.section == 0) {
            
            let photosCollectionViewController = PhotosViewController()
        }
        
        func numberOfSections(in tableView: UITableView) -> Int {
            return 2
        }
        
        func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
            if section == 0 { return UITableView.automaticDimension }
            return 0
        }
    }
}


