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
    
    private var currentUser: User?
    private let currentUserLogin: String
    private let userService: UserService
    
    private lazy var tableView = UITableView(frame: view.bounds, style: .grouped)
    
    private let headerView = ProfileHeaderView()
    
    var collection: [UIImage] = []
    
    private var fullscreenBackgroundView: UIView = {
        let fullscreenBackgroundView = UIView()
        fullscreenBackgroundView.backgroundColor = .black
        
        fullscreenBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        
        return fullscreenBackgroundView
    }()
    
    private var avatarImageView: UIImageView = {
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
    
    let crossImage: UIImageView = {
        let crossImage = UIImageView()
        crossImage.image = UIImage(systemName: "multiply")

        crossImage.isUserInteractionEnabled = true
        crossImage.translatesAutoresizingMaskIntoConstraints = false

        return crossImage
    }()
    
    // MARK: - Init
    init(userService: UserService, typedLogin: String) {
        
        self.userService = userService
        self.currentUserLogin = typedLogin
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        
        check(user: currentUserLogin)
        
        self.avatarImageView.image = currentUser?.userAvatar

        #if DEBUG
        view.backgroundColor = .systemRed
        #else
        view.backgroundColor = .systemGray6
        #endif

        setupConstraints()
        setupTableView()
        setupGestures()
        
        fullscreenBackgroundView.alpha = 0
        crossImage.alpha = 0
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        avatarImageView.layer.cornerRadius = view.bounds.width * 0.3 / 2
        
    }
    
    private func setupTableView() {
        navigationController?.tabBarController?.tabBar.isHidden = false
        navigationController?.navigationBar.isHidden = true
        
        tableView.register(PostTableViewCell.self, forCellReuseIdentifier: String(describing: PhotosTableViewCell.self))
        tableView.register(PostTableViewCell.self, forCellReuseIdentifier: reusedID)
        tableView.register(
            ProfileHeaderView.self,
            forHeaderFooterViewReuseIdentifier: String(describing: ProfileHeaderView.self)
        )
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    private func check(user: String){
        do {
            self.currentUser = try userService.currentUser(userLogin: user)
        } catch LoginError.serverError {
            let error = "User not found"
            
            DispatchQueue.main.async { [self] in
                let alertController = UIAlertController(title: error, message: "Something went wrong on the server side. Please, try to log in again", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "ОК...", style: .default) { _ in
                    print(error)
                    self.navigationController?.popViewController(animated: true)
                }
                alertController.addAction(okAction)
            
                present(alertController, animated: true, completion: nil)
            }
        } catch {
            let error = "Unknown error been cathced"
            
            DispatchQueue.main.async { [self] in
                let alertController = UIAlertController(title: error, message: "Something went wrong. Please, reload the app", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "ОК...", style: .default) { _ in
                    print(error)
                    fatalError(error)
                }
                alertController.addAction(okAction)
            
                present(alertController, animated: true, completion: nil)
            }
        }
    }
    
    // MARK: Setup Constraints
    private func setupConstraints() {
        view.addSubview(tableView)
        view.addSubviews(fullscreenBackgroundView,avatarImageView, crossImage)
        fullscreenBackgroundView.frame = .init(
            x: 0,
            y: 0,
            width: view.bounds.width,
            height: view.bounds.height
        )
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        let constraints = [
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            avatarImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            avatarImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            avatarImageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.3),
            avatarImageView.heightAnchor.constraint(equalTo: avatarImageView.widthAnchor),
            
            crossImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: view.bounds.width * 0.05),
            crossImage.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -1 * view.bounds.width * 0.05),
            crossImage.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.1),
            crossImage.heightAnchor.constraint(equalTo: crossImage.widthAnchor)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    // MARK: Setup Gestures
    private func setupGestures() {
        // Tap on AvatarImage Gesture
        let tapOnAvatarImageGusture = UITapGestureRecognizer(target: self, action: #selector(tapOnAvatarImage))
        headerView.addGestureRecognizer(tapOnAvatarImageGusture)
        headerView.isUserInteractionEnabled = true
        
        // Tap on background of AvatarFullscreenView
        let tapOnBackroundFullscreenGesture = UITapGestureRecognizer(target: self, action: #selector(tapOnBackground))
        fullscreenBackgroundView.addGestureRecognizer(tapOnBackroundFullscreenGesture)
        
        let tapOnCrossImageGesture = UITapGestureRecognizer(target: self, action: #selector(tapOnCrossImage))
        crossImage.addGestureRecognizer(tapOnCrossImageGesture)
    }
    
    // Tap on Avatar
    @objc func tapOnAvatarImage() {
        print("You tapped avatar image")
        if animationWasShownMark {
            avatarImageView.alpha = 1
            avatarImageBecomeFullscreenBasicAnimation()
            avatarImageView.isUserInteractionEnabled = false
            fullscreenBackgroundView.isUserInteractionEnabled = true
            crossImage.isUserInteractionEnabled = true
            fullscreenBackgroundView.alpha = 0.5
            crossImage.alpha = 1
        } else {
            print("!!!SOMETHING IS WRONG!!!")
            avatarImageView.isUserInteractionEnabled = true
        }
        animationWasShownMark.toggle()
    }
    
    // Tap on fullscreen background
    @objc func tapOnBackground() {
        print("I'M NOT A CROSS")
    }
    
    // Tap on cross
    @objc func tapOnCrossImage() {
        print("You tapped cross")
        avatarImageBackToNormalBasicAnimation()
        fullscreenBackgroundView.alpha = 0
        crossImage.alpha = 0
        avatarImageView.alpha = 0
        animationWasShownMark.toggle()
        avatarImageView.isUserInteractionEnabled = true
        fullscreenBackgroundView.isUserInteractionEnabled = false
        crossImage.isUserInteractionEnabled = false
    }
    
    // MARK: - Animations
    
    
    
    // MARK: Avatar become fullscreen animation
    func avatarImageBecomeFullscreenBasicAnimation() {
        let centerXPositionAnimation = CABasicAnimation(keyPath: "position.x")
        centerXPositionAnimation.toValue = view.bounds.maxX / 2

        let centerYPositionAnimation = CABasicAnimation(keyPath: "position.y")
        centerYPositionAnimation.toValue = view.bounds.maxY / 2

        let xScaleAnimation = CABasicAnimation(keyPath: "transform.scale.x")
        xScaleAnimation.fromValue = 1
        xScaleAnimation.toValue = 3

        let yScaleAnimation = CABasicAnimation(keyPath: "transform.scale.y")
        yScaleAnimation.fromValue = 1
        yScaleAnimation.toValue = 3
        
        let avatarAlphaAnimation = CABasicAnimation(keyPath: "opacity")
        avatarAlphaAnimation.fromValue = 0.5
        avatarAlphaAnimation.toValue = 1
        
        let avatarCornerRadiusAnimation = CABasicAnimation(keyPath: "cornerRadius")
        avatarCornerRadiusAnimation.fromValue = avatarImageView.layer.cornerRadius
        avatarCornerRadiusAnimation.toValue = 0
        
        let groupForAvatar = CAAnimationGroup()
        groupForAvatar.animations = [centerXPositionAnimation, centerYPositionAnimation, xScaleAnimation, yScaleAnimation, avatarAlphaAnimation, avatarCornerRadiusAnimation]

        groupForAvatar.duration = 0.5
        groupForAvatar.isRemovedOnCompletion = false
        groupForAvatar.fillMode = .forwards

        avatarImageView.layer.add(groupForAvatar, forKey: "image animation")
        
        let backgroundAlphaAnimation = CABasicAnimation(keyPath: "opacity")
        backgroundAlphaAnimation.fromValue = 0
        backgroundAlphaAnimation.toValue = 0.5
        
        let groupForBackground = CAAnimationGroup()
        groupForBackground.animations = [backgroundAlphaAnimation]
        
        groupForBackground.duration = 0.5
        groupForBackground.isRemovedOnCompletion = false
        groupForBackground.fillMode = .forwards
        
        fullscreenBackgroundView.layer.add(groupForBackground, forKey: "background animation")
        
        let crossDelayAnimation = CABasicAnimation(keyPath: "opacity")
        crossDelayAnimation.fromValue = 0
        crossDelayAnimation.toValue = 0
        
        let groupForDelay = CAAnimationGroup()
        groupForDelay.animations = [crossDelayAnimation]
        
        groupForDelay.duration = 0.5
        
        crossImage.layer.add(groupForDelay, forKey: "delay animation")
        
        let crossImageAlphaAnimation = CABasicAnimation(keyPath: "opacity")
        crossImageAlphaAnimation.fromValue = 0
        crossImageAlphaAnimation.toValue = 1
        
        let groupForCross = CAAnimationGroup()
        groupForCross.animations = [crossImageAlphaAnimation]
        
        groupForCross.beginTime = CACurrentMediaTime() + 0.5
        groupForCross.duration = 0.3
        groupForCross.isRemovedOnCompletion = false
        groupForCross.fillMode = .forwards
        
        crossImage.layer.add(groupForCross, forKey: "cross image animation")
    }
    
    // MARK: Avatar become back to normal animation
    func avatarImageBackToNormalBasicAnimation() {
        let centerXPositionAnimation = CABasicAnimation(keyPath: "position.x")
        centerXPositionAnimation.fromValue = view.bounds.maxX / 2
        centerXPositionAnimation.toValue = avatarImageView.center.x

        let centerYPositionAnimation = CABasicAnimation(keyPath: "position.y")
        centerYPositionAnimation.fromValue = view.bounds.maxY / 2
        centerYPositionAnimation.toValue = avatarImageView.center.y

        let xScaleAnimation = CABasicAnimation(keyPath: "transform.scale.x")
        xScaleAnimation.fromValue = 3
        xScaleAnimation.toValue = 1

        let yScaleAnimation = CABasicAnimation(keyPath: "transform.scale.y")
        yScaleAnimation.fromValue = 3
        yScaleAnimation.toValue = 1
        
        let avatarAlphaAnimation = CABasicAnimation(keyPath: "opacity")
        avatarAlphaAnimation.fromValue = 1
        avatarAlphaAnimation.toValue = 0
        
        let avatarCornerRadiusAnimation = CABasicAnimation(keyPath: "cornerRadius")
        avatarCornerRadiusAnimation.fromValue = 0
        avatarCornerRadiusAnimation.toValue = avatarImageView.layer.cornerRadius
        
        let groupForAvatar = CAAnimationGroup()
        groupForAvatar.animations = [centerXPositionAnimation, centerYPositionAnimation, xScaleAnimation, yScaleAnimation, avatarAlphaAnimation, avatarCornerRadiusAnimation]

        groupForAvatar.duration = 0.5
        groupForAvatar.isRemovedOnCompletion = false
        groupForAvatar.fillMode = .forwards

        avatarImageView.layer.add(groupForAvatar, forKey: "image animation")
        
        let backgroundAlphaAnimation = CABasicAnimation(keyPath: "opacity")
        backgroundAlphaAnimation.fromValue = 0.5
        backgroundAlphaAnimation.toValue = 0
        
        let groupForBackground = CAAnimationGroup()
        groupForBackground.animations = [backgroundAlphaAnimation]
        
        groupForBackground.duration = 0.5
        groupForBackground.isRemovedOnCompletion = false
        groupForBackground.fillMode = .forwards
        
        fullscreenBackgroundView.layer.add(groupForBackground, forKey: "background animation")
        
        let crossImageAlphaAnimation = CABasicAnimation(keyPath: "opacity")
        crossImageAlphaAnimation.fromValue = 1
        crossImageAlphaAnimation.toValue = 0
        
        let groupForCross = CAAnimationGroup()
        groupForCross.animations = [crossImageAlphaAnimation]
        
        groupForCross.duration = 0.5
        groupForCross.isRemovedOnCompletion = false
        groupForCross.fillMode = .forwards
        
        crossImage.layer.add(groupForCross, forKey: "background animation")
    }
    
}

// MARK: Extensions
extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
    
        func numberOfSections(in tableView: UITableView) -> Int {
            return 2
        }
        
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
        
        func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
            if section != 0 { return nil }
            return profileHeaderView
        }
        
        func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
            if section == 0 { return UITableView.automaticDimension }
            return 0
        }
    }



