//
//  InfoViewController.swift
//  Navigation_IOS_38_Ganbarova
//
//  Created by Aysel on 05.10.2023.
//

import UIKit

class InfoViewController: UIViewController {
    
    private lazy var button: UIButton = {
        let button = UIButton()
        button.backgroundColor = .blue
        button.layer.cornerRadius = 12
        button.setTitle("Перейти на пост", for: .normal)
        button.setTitleColor(.lightGray, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.addTarget(self, action: #selector(showACPressed(_sender: )), for: .touchUpInside)
        
        return button
        
    }()
    
    private let label: UILabel = UILabel()
    private let planetLabel: UILabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(button)
        view.addSubview(label)
        view.addSubview(planetLabel)
        
        label.frame = .init(x: 16, y: 50, width: view.bounds.width - 32, height: 100)
        label.numberOfLines = 0
        
        planetLabel.frame = .init(x: 16, y: 50, width: view.bounds.width - 32, height: 100)
        planetLabel.numberOfLines = 0
        
        NSLayoutConstraint.activate([
            button.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            button.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            button.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            button.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        getUsers()
    }
    
    @objc func showACPressed(_sender: UIButton) {
        let alertController = UIAlertController(title: "Вход", message: "введите данные для входа", preferredStyle: .alert)
        let  alerOkAction = UIAlertAction(title: "OK", style: .default, handler: {_ in
            print("нажали кнопку ОК")
        })
        let cancel = UIAlertAction(title: "Закрыть", style: .default, handler: { _ in print("нажали кнопку cancel")
        })
        
        alertController.addAction(alerOkAction)
        alertController.addAction(cancel)
        
        present(alertController, animated: true)
        
    }
    
    func getUsers() {
        NetworkService.getUser { [weak self] data, error in
            guard let data = data else {
                print(error?.localizedDescription)
                return
            }
            
            do {
                let value = try JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                print(value)
                let title = value["title"] as? String
                DispatchQueue.main.async {
                    self?.label.text = title
                }
            }
            
            catch let error {
                print(error.localizedDescription)
            }
        }
    }
    
}
