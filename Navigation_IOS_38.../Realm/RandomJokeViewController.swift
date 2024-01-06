//
//  RandomJokeViewController.swift
//  Navigation_IOS_38...
//
//  Created by Aysel on 30.12.2023.
//

import UIKit

final class RandomJokeViewController: UIViewController {
    
    private let jokeLabel = UILabel()
    
    private let loadButton: UIButton = {
        let button = UIButton()
        button.setTitle("Загрузить", for: .normal)
        button.configuration = .borderedTinted()
        return button
    }()
    
    private let networkService: JokeNetworkService
    private let storageService: JokeStorageService
    
    init(
        networkService: JokeNetworkService,
        storageService: JokeStorageService
    ) {
        self.storageService = storageService
        self.networkService = networkService
        super.init(nibName: nil, bundle: nil)
        title = "Случайная"
        tabBarItem.image = UIImage(systemName: "pencil")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        layout()
        setUpSubviews()
    }
    
    @objc func loadButtonDidTap() {
        networkService.loadJoke { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let response):
                DispatchQueue.main.async {
                    self.jokeLabel.text = response.value
                    self.jokeLabel.textColor = .black
                }
                
                guard self.storageService.save(from: response) else { fallthrough }
            case .failure:
                DispatchQueue.main.async {
                    self.jokeLabel.text = "Error"
                    self.jokeLabel.textColor = .systemRed
                }
            }
        }
    }
    
    private func setUpSubviews() {
        view.backgroundColor = .white
        jokeLabel.numberOfLines = .zero
        jokeLabel.textAlignment = .center
        jokeLabel.text = "Шутка не загружена"
        loadButton.addTarget(self, action: #selector(loadButtonDidTap), for: .touchUpInside)
    }
    
    private func layout() {
        view.addSubviews(jokeLabel, loadButton)
        
        loadButton.translatesAutoresizingMaskIntoConstraints = false
        jokeLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            jokeLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            jokeLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            jokeLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            loadButton.topAnchor.constraint(equalTo: jokeLabel.bottomAnchor, constant: 10),
            loadButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            loadButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40)
        ])
    }
}
