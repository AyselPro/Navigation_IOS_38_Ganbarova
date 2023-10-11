//
//  ProfileViewController.swift
//  Navigation_IOS_38_Ganbarova
//
//  Created by Aysel on 05.10.2023.
//

import UIKit

final class ProfileViewController: UIViewController {
    
    private let profileHeaderView: ProfileHeaderView = ProfileHeaderView()
    private var arrayImages = [String]()
    private let tableView = UITableView()
    private let newButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .lightGray
        navigationController?.navigationBar.isHidden = true
        
        for i in 1...30 {
            let string = "image-\(i)"
            guard let _ = UIImage(named: string) else { continue }
            arrayImages.append(string)
        }
        setupView()
        newButton.setTitle("Новая кнопка", for: .normal)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
    
    private func setupView() {
        view.addSubviews(profileHeaderView, tableView, newButton)
        
        NSLayoutConstraint.activate([
            profileHeaderView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            profileHeaderView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            profileHeaderView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            profileHeaderView.heightAnchor.constraint(equalToConstant: 220),

            tableView.topAnchor.constraint(equalTo: profileHeaderView.bottomAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            newButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            newButton.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            newButton.trailingAnchor.constraint(equalTo: view.trailingAnchor),

        ])
        
        tableView.register(PhotosTableViewCell.self, forCellReuseIdentifier: PhotosTableViewCell.identifier)
        tableView.register(PhotoTableViewCell.self, forCellReuseIdentifier: PhotoTableViewCell.identifier)
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
    }
}


//MARK: UITableViewDataSource and UITableViewDelegate
extension ProfileViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0: return 1
        default: return arrayImages.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: PhotosTableViewCell.identifier, for: indexPath) as? PhotosTableViewCell else { return UITableViewCell()}
            cell.setupView(images: arrayImages)
            return cell
            
        default:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: PhotoTableViewCell.identifier, for: indexPath) as? PhotoTableViewCell else { return UITableViewCell()}
            let name = arrayImages[indexPath.row]
            cell.setupView(image: name)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.section == 0 {
            let vc = PhotosViewController()
            vc.images = arrayImages
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
}

