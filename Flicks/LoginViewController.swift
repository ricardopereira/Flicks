//
//  LoginViewController.swift
//  Flicks
//
//  Created by Ricardo Pereira on 21/01/2020.
//  Copyright © 2020 Ricardo Pereira. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    let viewModel: LoginViewModel

    lazy var mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    lazy var secretTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.placeholder = "API Key"
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()

    lazy var loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Login", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    init(viewModel: LoginViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Authentication"
        view.backgroundColor = .white

        view.addSubview(mainStackView)
        NSLayoutConstraint.activate([
            mainStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            mainStackView.leadingAnchor.constraint(equalTo: view.readableContentGuide.leadingAnchor, constant: 15),
            mainStackView.trailingAnchor.constraint(equalTo: view.readableContentGuide.trailingAnchor, constant: -15),
        ])

        mainStackView.addArrangedSubview(secretTextField)
        mainStackView.addArrangedSubview(loginButton)

        loginButton.addTarget(self, action: #selector(self.loginButtonTapped), for: .touchUpInside)
    }

    @objc func loginButtonTapped() {
        viewModel.login(secret: secretTextField.text ?? "")
    }

}
