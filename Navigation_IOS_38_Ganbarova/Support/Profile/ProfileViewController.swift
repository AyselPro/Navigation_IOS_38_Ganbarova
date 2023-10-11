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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .lightGray
        navigationController?.navigationBar.isHidden = true
        
        for i in 1...30 {
            let string = "image-\(i)"
            guard let image = UIImage(named: string) else { continue }
            arrayImages.append(string)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        view.addSubviews(profileHeaderView, tableView)
        
        NSLayoutConstraint.activate([
            profileHeaderView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            profileHeaderView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            profileHeaderView.trailingAnchor.constraint(equalTo: view.trailingAnchor),

            tableView.topAnchor.constraint(equalTo: profileHeaderView.bottomAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(PhotosTableViewCell.self, forCellReuseIdentifier: PhotosTableViewCell.identifier)
        tableView.register(PhotoTableViewCell.self, forCellReuseIdentifier: PhotoTableViewCell.identifier)
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


//MARK: - SwiftUI
import SwiftUI
struct ProfileViewController_Provider : PreviewProvider {
    static var previews: some View {
        ContainterView().edgesIgnoringSafeArea(.all)
    }
    
    struct ContainterView: UIViewControllerRepresentable {
        func makeUIViewController(context: Context) -> UIViewController {
            return ProfileViewController()
        }
        
        typealias UIViewControllerType = UIViewController
        
        
        let viewController = ProfileViewController()
        func makeUIViewController(context: UIViewControllerRepresentableContext<ProfileViewController_Provider.ContainterView>) -> ProfileViewController {
            return viewController
        }
        
        func updateUIViewController(_ uiViewController: ProfileViewController_Provider.ContainterView.UIViewControllerType, context: UIViewControllerRepresentableContext<ProfileViewController_Provider.ContainterView>) {
            
        }
    }
}







