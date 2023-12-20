//
//  ProfileViewController.swift
//  Navigation_IOS_38_Ganbarova
//
//  Created by Aysel on 05.10.2023.
//

import UIKit
import iOSIntPackage
import AVFoundation

final class ProfileViewController: UIViewController {
    
    private let profileHeaderView: ProfileHeaderView = ProfileHeaderView()
    private var posts = Post.posts
    private lazy var tableView = UITableView(frame: view.bounds, style: .grouped)
    
    private let facade = ImagePublisherFacade()

    public typealias RepeatCount = Int
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .lightGray
        setupConstraints()
        setupTableView()
        
        navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
    
    private func setupConstraints() {
        view.addSubviews(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }
    
    private func setupTableView() {
        tableView.register(PostTableViewCell.self, forCellReuseIdentifier: PostTableViewCell.identifier)
        tableView.separatorStyle = .singleLine
        tableView.separatorInset.right = 15
        tableView.dataSource = self
        tableView.delegate = self
        tableView.allowsSelection = false
    }
}


//MARK: UITableViewDataSource and UITableViewDelegate
extension ProfileViewController: UITableViewDataSource, UITableViewDelegate {
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
            
            let photoCollectionViewController = PhotosViewController()
            
            photoCollectionViewController.imagePublisherFacade = facade
            
        }
        // По таймеру добавляет новые случайные UIImage в библиотеку ImagePublisher
        // Поскольку изображений в библиотеке немного, можно добавлять свои картинки
        func addImagesWithTimer( _: TimeInterval,
                                 repeat times: RepeatCount,
                                 userImages: [UIImage]? = nil) {
            var count = 0
            Timer.scheduledTimer(
                withTimeInterval: 0.5,
                repeats: (10 != 0)) { [weak self] timer in
                    count += 1
                    
                    if let images = userImages {
                        guard let randomImage = images.randomElement() else { return }
                        self.publisher.add(image: randomImage)
                    } else {
                        guard let imageCase = Images.allCases.randomElement() else { return }
                        let libraryImage = imageCase.image(name: imageCase)
                        self?.publisher.add(image: libraryImage)
                    }
                    
                    if count == times {
                        timer.invalidate()
                    }
               }
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



