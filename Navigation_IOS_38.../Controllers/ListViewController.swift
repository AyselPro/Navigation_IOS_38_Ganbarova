//
//  ListViewController.swift
//  Navigation_IOS_38...
//
//  Created by Aysel on 23.12.2023.
//

import UIKit

final class ListViewController: UIViewController {
    
    private let fileManagerService: FileManagerService
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        return tableView
    }()
    
    init(fileManagerService: FileManagerService) {
        self.fileManagerService = fileManagerService
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layout()
        
        title = fileManagerService.rootFolderName
        
        navigationController?.navigationBar.prefersLargeTitles = true
        
        let addFolder = UIBarButtonItem(
            image: UIImage(systemName: "folder.badge.plus"),
            style: .plain,
            target: self,
            action: #selector(addFolderButtonDidTap)
        )
        let addFile = UIBarButtonItem(
            image: UIImage(systemName: "plus"),
            style: .plain,
            target: self,
            action: #selector(addFileButtonDidTap)
        )
        navigationItem.rightBarButtonItems = [addFile, addFolder]
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tableView.reloadData()
    }
    
    @objc private func addFolderButtonDidTap() {
        let alert = UIAlertController(title: "Create folder", message: nil, preferredStyle: .alert)

        alert.addTextField { (textField) in
            textField.placeholder = "Folder name"
        }

        alert.addAction(
            UIAlertAction(title: "Create", style: .default) { [weak alert, weak self] (_) in
                guard let textField = alert?.textFields?.first else { return }
                
                self?.fileManagerService.addDirectory(name: textField.text ?? UUID().uuidString)
                
                self?.tableView.reloadData()
            }
        )
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        
        present(alert, animated: true, completion: nil)
    }
    
    @objc private func addFileButtonDidTap() {
        let picker = UIImagePickerController()
        picker.allowsEditing = false
        picker.delegate = self
        present(picker, animated: true)
    }
    
    private func layout() {
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
}

extension ListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        fileManagerService.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        var content = cell.defaultContentConfiguration()
        content.text = fileManagerService.items[indexPath.row]
        
        let isFolder = fileManagerService.isDirectoryAtIndex(indexPath.row)
        
        content.secondaryText = isFolder ? "Папка" : "Файл"
        cell.contentConfiguration = content
        cell.accessoryType = isFolder ? .disclosureIndicator : .none
        return cell
    }
}

extension ListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            fileManagerService.deleteItem(at: indexPath.row)
            tableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard fileManagerService.isDirectoryAtIndex(indexPath.row) else { return }
        
        let path = fileManagerService.getPath(at: indexPath.row)
        let fileManagerService = FileManagerService(pathForFolder: path, userDefaults: .standard)
        let nextListViewController = ListViewController(fileManagerService: fileManagerService)
        navigationController?.pushViewController(nextListViewController, animated: true)
    }
}

extension ListViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(
        _ picker: UIImagePickerController,
        didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]
    ) {
        guard
            let image = info[.originalImage] as? UIImage,
            let pngData = image.pngData()
        else { return }

        fileManagerService.createFile(name: "\(UUID().uuidString).png", content: pngData)
        
        tableView.reloadData()
        dismiss(animated: true)
    }
}
