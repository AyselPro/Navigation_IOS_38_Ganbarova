//
//  JokesViewController.swift
//  Navigation_IOS_38...
//
//  Created by Aysel on 30.12.2023.
//

import UIKit

final class JokesViewController: UIViewController {
    
    private var jokesData: [JokeModel] = []
    private let storageService: JokeStorageService
    
    private lazy var refreshControl: UIRefreshControl = {
        let control = UIRefreshControl()
        control.addTarget(self, action: #selector(reloadTableData), for: .valueChanged)
        return control
    }()
    
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.calendar = Calendar(identifier: .iso8601)
        formatter.dateFormat = "yyyy-dd-MM HH:mm"
        return formatter
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
        title = "Сортированные"
        tabBarItem.image = UIImage(systemName: "list.bullet")
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
        jokesData = storageService.fetchModelsSortedByTime()
        tableView.reloadData()
        refreshControl.endRefreshing()
    }
}

extension JokesViewController:  UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        jokesData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        var content = cell.defaultContentConfiguration()
        let jokeData = jokesData[indexPath.row]
        content.text = jokeData.value
        content.secondaryText = dateFormatter.string(from: jokeData.createdAt)
        cell.contentConfiguration = content
        return cell
    }
}

extension JokesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
