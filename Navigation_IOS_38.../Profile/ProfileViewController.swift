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

    let viewModel: ProfileVM
    
   // var coordinator: ProfileBaseCoordinator?
    
    private lazy var goToProfile2button: CustomButton = {
        let btn = CustomButton.init(titleText: "Go to Detail Profile", titleColor: .white, backgroundColor: .black, tapAction: goToProfile2)
        btn.layer.borderColor = UIColor.black.cgColor
        btn.layer.borderWidth = 2
        return btn
    }()

    private let profileHeaderView: ProfileHeaderView = ProfileHeaderView()
    private var posts = Post.posts
    
    private var userNotLoggedInMark = true
    private var animationWasShownMark = true
    private let reusedID = "cellID"
    
    //TODO: отобразить
    private var user: User
    private var login: String { return user.login }
    
    private lazy var tableView = UITableView(frame: view.bounds, style: .grouped)
    
    private let facade = ImagePublisherFacade()
    
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
    init(user: User, viewModel: ProfileVM) {
        self.user = user
        self.viewModel = viewModel
       // self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
        title = "Profile"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        //
        view.backgroundColor = .red
        self.avatarImageView.image = user.avatar
        view.backgroundColor = .lightGray
        setupTableView()
        view.backgroundColor = .red
        setupUI()
        
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
    
    private func  setupUI() {
        view.addSubview(goToProfile2button)
        
        NSLayoutConstraint.activate([
            goToProfile2button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            goToProfile2button.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    @objc private func goToProfile2() {
        viewModel.onDetail?()
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if (indexPath.section == 0) {
            
            let photoCollectionViewController = PhotosViewController()
            
            Post.posts.forEach {
                collection.append(UIImage(imageLiteralResourceName: $0.image))
            }
            
         //   photoCollectionViewController.imagePublisherFacade = facade
            
          //  photoCollectionViewController.imagePublisherFacade?.addImagesWithTimer(time: 0.5, repeat: 10, userImages: collection)
            
            navigationController?.pushViewController(photoCollectionViewController, animated: true)
        } else {
            return
        }
    }
}
