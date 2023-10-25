//
//  ViewController.swift
//  Navigation_IOS_38_Ganbarova
//
//  Created by Aysel on 05.10.2023.
//

import UIKit

class ViewController: UIViewController {
    
    //
    private let contactButton: UIButton = {
        let button = UIButton()
        button.setTitle("Log In", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 10
        button.addTarget(ViewController.self, action: #selector(buttonPressed), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        
        
        setupViews()
        setupConstraints()
    }
    
    private func setupViews() {
        title = "Log In"
        view.addSubview(contactButton)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            contactButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            contactButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            contactButton.heightAnchor.constraint(equalToConstant: 50),
            
        ])
    }
    
    @objc func buttonPressed(_sender: UIButton) {
        let vc = LogInViewController()
        present(vc, animated: true)
    }
    
    
    
    
    
    
    
    
    
    
    //1
    let color = UIColor(named: "#4885CC")
    
    
    //5
    @objc private func tapBurButtonItamAction() {
        let LogInViewController = LogInViewController()
        navigationController?.pushViewController(LogInViewController, animated: true)
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
