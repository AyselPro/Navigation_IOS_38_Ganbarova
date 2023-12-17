//
//  FeedViewController.swift
//  Navigation_IOS_38_Ganbarova
//
//  Created by Aysel on 05.10.2023.
//

import UIKit

class FeedViewController: UIViewController {
    
    private var post = Post(author: "", description: "", image: "", likes: 0, views: 0)
    
    private let stackView: UIStackView = .init()
    
   // var viewModel: FeedModel
    
    let viewModel: FeedVM
    
   // var coordinator: FeedBaseCoordinator?
    
    private lazy var goToFeed2button: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("Go to Detail", for: .normal)
        btn.layer.borderColor = UIColor.black.cgColor
        btn.layer.borderWidth = 2
        btn.backgroundColor = .black
        btn.addTarget(self, action: #selector(goToFeed2), for: .touchUpInside)
        return btn
    }()
    
    // Button for checking word
    private lazy var checkGuessButton: CustomButton  = {
        let button = CustomButton.init(titleText: "Check", titleColor: .white, backgroundColor: .gray, tapAction: tapCheckAction)
        button.setTitleColor(.black, for: .selected)
        button.setTitleColor(.black, for: .highlighted)
        button.layer.cornerRadius = 10
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.masksToBounds = true
        return button
    }()
    
    private lazy var secretwordTextField: UITextField = {
        let secretwordTextField = UITextField()
        secretwordTextField.placeholder = "Place for password to be checked"
        secretwordTextField.font = UIFont.systemFont(ofSize: 15)
        secretwordTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 40))
        secretwordTextField.layer.cornerRadius = 12
        secretwordTextField.layer.borderWidth = 1
        secretwordTextField.layer.borderColor = UIColor.white.cgColor
        
        return secretwordTextField
    }()
    
    private lazy var textField: UITextField = {
        let textField = UITextField(frame: .init(x: 20, y: 100, width: view.bounds.width - 40, height: 40))
        textField.placeholder = "Place for password to be checked"
        textField.font = UIFont.systemFont(ofSize: 15)
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 40))
        textField.layer.cornerRadius = 12
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.white.cgColor
        return textField
    }()
    
    private var resultLabel: UILabel = {
        let resultLabel = UILabel()
        resultLabel.font = UIFont.boldSystemFont(ofSize: 10)
        resultLabel.numberOfLines = 0
        resultLabel.textColor = .black
        resultLabel.backgroundColor = .systemGray3
        resultLabel.textAlignment = .center
        resultLabel.layer.cornerRadius = 20
        resultLabel.layer.borderWidth = 1
        resultLabel.layer.borderColor = UIColor.black.cgColor
        resultLabel.layer.masksToBounds = true
        
        resultLabel.translatesAutoresizingMaskIntoConstraints = false
        
        return resultLabel
    }()
    
    init(viewModel: FeedVM) {
        self.viewModel = viewModel
        // self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
        title = "Feed"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        stackView.axis = .vertical
        view.backgroundColor = .lightGray
        view.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemGray5
        setupUI()
        
        view.addSubview(textField)
        view.addSubview(checkGuessButton)
        view.addSubview(resultLabel)
        
        NSLayoutConstraint.activate([
            checkGuessButton.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 10),
            checkGuessButton.leadingAnchor.constraint(equalTo: textField.leadingAnchor),
            checkGuessButton.trailingAnchor.constraint(equalTo: textField.trailingAnchor),
            checkGuessButton.heightAnchor.constraint(equalToConstant: 40),
            
            resultLabel.topAnchor.constraint(equalTo: checkGuessButton.bottomAnchor, constant: 10),
            resultLabel.leadingAnchor.constraint(equalTo: checkGuessButton.leadingAnchor),
            resultLabel.trailingAnchor.constraint(equalTo: checkGuessButton.trailingAnchor),
            resultLabel.heightAnchor.constraint(equalToConstant: 40),
        ])
        
        NotificationCenter.default.addObserver(self, selector: #selector(checkWord(_:)), name: FeedModel.key, object: nil)
        
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }
    
        private func  setupUI() {
            view.addSubview(goToFeed2button)
            
            NSLayoutConstraint.activate([
                goToFeed2button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                goToFeed2button.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 200)
            ])
        
        let firstButton = UIButton()
        let secondButton = UIButton()
        
        firstButton.setTitle("Первая кнопка", for: .normal)
        secondButton.setTitle("Вторая кнопка", for: .normal)
        
        stackView.addArrangedSubview(firstButton)
        stackView.addArrangedSubview(secondButton)
        stackView.spacing = 10
        
        firstButton.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        secondButton.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
    }
    
    @objc private func goToFeed2() {
        viewModel.onNext?()
    }
    
    @objc private func checkWord(_ notification: NSNotification) {
        guard let object = notification.object as? Bool else { return }
        object ? trueSelector() : falseSelector()
    }
    
    
    @objc private func tapCheckAction() {
        guard let text = textField.text, !text.isEmpty else { return }
        let feedModel = FeedModel()
        feedModel.check(word: text)
    }
    
    //true- green
    @objc func trueSelector() {
        print("Password is true")
        
        resultLabel.text = "You've done well!"
        resultLabel.textColor = .green
        resultLabel.layer.borderColor = UIColor.green.cgColor
        resultAnimation()
    }
    //false-red
    @objc func falseSelector() {
        print("Password is false")
        
        resultLabel.text = "Wrong! Try again."
        resultLabel.textColor = .red
        resultLabel.layer.borderColor = UIColor.red.cgColor
        resultAnimation()
    }
    
    func resultAnimation() {
        
    }
    
    @objc private func buttonAction() {
        let postViewController = PostViewController(post: post)
        
        //1
        self.navigationController?.pushViewController(postViewController, animated: true)
        
        //2
        //        postViewController.modalTransitionStyle = .flipHorizontal
        //        postViewController.modalPresentationStyle = .fullScreen
        //        present(postViewController, animated: true)
    }
}


