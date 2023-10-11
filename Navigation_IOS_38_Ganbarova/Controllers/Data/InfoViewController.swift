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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(button)
        
        NSLayoutConstraint.activate([
            button.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            button.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            button.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            button.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
