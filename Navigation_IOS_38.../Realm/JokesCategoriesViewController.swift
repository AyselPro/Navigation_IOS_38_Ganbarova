//
//  GroupedJokesViewController.swift
//  Navigation_IOS_38...
//
//  Created by Aysel on 30.12.2023.
//

import UIKit

// Теперь этот экран просто отображает список из категорий.
final class JokesCategoriesViewController: UIViewController {
    
    // Теперь сами шутки здесь не нужны, поэтому хватит просто String.
    private var jokeCategoriesData: [String] = []
    private let storageService: JokeStorageService
    
    private lazy var refreshControl: UIRefreshControl = {
        let control = UIRefreshControl()
        control.addTarget(self, action: #selector(reloadTableData), for: .valueChanged)
        return control
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.refreshControl = refreshControl
        return tableView
    }()
    
    init(storageService: JokeStorageService) {
        self.storageService = storageService
        super.init(nibName: nil, bundle: nil)
        title = "Категории"
        tabBarItem.image = UIImage(systemName: "tray.full.fill")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        layout()
        reloadTableData()
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
    
    @objc private func reloadTableData() {
        jokeCategoriesData = storageService.fetchCategories()
        tableView.reloadData()
        refreshControl.endRefreshing()
    }
}

extension JokesCategoriesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        jokeCategoriesData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        var content = cell.defaultContentConfiguration()
        content.text = jokeCategoriesData[indexPath.row]
        cell.contentConfiguration = content
        return cell
    }
}

extension JokesCategoriesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        // По нажатию на категорию в таблице открываем новый экран с шутками для выбранной категории.
        let jokesVC = JokesForCategoriesViewController(
            storageService: storageService,
            category: jokeCategoriesData[indexPath.row]
        )
        navigationController?.pushViewController(jokesVC, animated: true)
    }
}
