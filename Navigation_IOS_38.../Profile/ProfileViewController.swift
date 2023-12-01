//
//  ProfileViewController.swift
//  Navigation_IOS_38_Ganbarova
//
//  Created by Aysel on 05.10.2023.
//

import UIKit
import StorageService
import iOSIntPackage

class ProfileViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
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
        
        check(user: login)
        
        self.avatarImageView.image = user.avatar
        
#if DEBUG
        view.backgroundColor = .systemRed
#else
        view.backgroundColor = .systemGray6
#endif
        setupTableView()
        setupGesture()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        avatarImageView.layer.cornerRadius = view.bounds.width * 0.3 / 2
        
    }
    
    private func setupTableView() {
        navigationController?.tabBarController?.tabBar.isHidden = false
        navigationController?.navigationBar.isHidden = true

        tableView.register(PhotosTableViewCell.self, forCellReuseIdentifier: String(describing: PhotosTableViewCell.self))
        tableView.register(PostTableViewCell.self, forCellReuseIdentifier: reusedID)
        //tableView.register(
                 //  ProfileHeaderView.self,
                   // forHeaderFooterViewReuseIdentifier: String(describing: ProfileHeaderView.self)
               // )
       tableView.dataSource = self
       tableView.delegate = self
    }
    
    private func check(user: String) {
        do {
            self.user = User(login: "Aysel1994", firstName: "Aysel", avatar: UIImage(), status: "живая")
            let user = self.user
            
        } catch let error {
            let text = error.localizedDescription
                
                DispatchQueue.main.async { [self] in
                    let alertController = UIAlertController(title: text, message: "Something went wrong on the server side. Please, try to log in again", preferredStyle: .alert)
                    let okAction = UIAlertAction(title: "ОК...", style: .default) { _ in
                        print(error)
                        self.navigationController?.popViewController(animated: true)
                    }
                    alertController.addAction(okAction)
                    
                    present(alertController, animated: true, completion: nil)
                }
            }
        }
    
    // MARK: Setup Gestures
    private func setupGesture() {
        // Tap on AvatarImage Gesture
        let tapOnAvatarImageGusture = UITapGestureRecognizer(target: self, action: #selector(tapOnAvatarImage))
        profileHeaderView.addGestureRecognizer(tapOnAvatarImageGusture)
        profileHeaderView.isUserInteractionEnabled = true
    }
    
    @objc func tapOnAvatarImage() {
        print("You tapped avatar image")
        if animationWasShownMark {
            avatarImageView.alpha = 1
            avatarImageView.isUserInteractionEnabled = false
        } else {
            print("!!!SOMETHING IS WRONG!!!")
            avatarImageView.isUserInteractionEnabled = true
        }
        
        //MARK: UITableViewDataSource and UITableViewDelegate
        
        func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
            let profileHeaderView = self.profileHeaderView
        
            return profileHeaderView
        }
        
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            if (indexPath.section == 0) {
                
                let photoCollectionViewController = PhotosViewController()
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
}
