//
//  PostListViewController.swift
//  Navigation_IOS_38...
//
//  Created by Aysel on 28.12.2023.
//

import UIKit

class PostListViewController: UIViewController {

    private let postService: IPostService
    
    private lazy var addBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addBarButtonAction))
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
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
        view.backgroundColor = .white
        layout()
    }
    
    @objc private func addBarButtonAction() {
        postService.createToDoModel(title: "Новый пост", author: "", image: "", likes: 150, views: 10)
        tableView.reloadData()
    }
    
    private func layout() {
        navigationItem.rightBarButtonItem = addBarButtonItem
        
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}



extension PostListViewController:  UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        postService.toDoItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
         var content = cell.defaultContentConfiguration()
         let toDoList = postService.toDoItems[indexPath.row]
       //  content.text = ToDoList.title
        // content.secondaryText = ToDoList.dateCreated?.formatted()
         cell.contentConfiguration = content
         return cell
     }
 }

extension PostListViewController: UITableViewDelegate {
        func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
            if editingStyle == .delete {
                postService.deleteToDoList(at: indexPath.row)
                tableView.reloadData()
            }
        }
        
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            tableView.deselectRow(at: indexPath, animated: true)
            
            
        }
}
