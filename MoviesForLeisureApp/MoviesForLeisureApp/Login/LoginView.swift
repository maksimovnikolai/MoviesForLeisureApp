//
//  LoginView.swift
//  MoviesForLeisureApp
//
//  Created by Nikolai Maksimov on 16.10.2024.
//

import UIKit
import SnapKit

final class LoginView: UIView {
    // MARK: - UI components
    
    private lazy var stackView: UIStackView = {
       let sv = UIStackView()
        sv.axis = .vertical
        [nameTextField, passwordTextField, authButton, authInfoLabel].forEach {
            sv.addArrangedSubview($0)
        }
        sv.spacing = 10
        sv.distribution = .fillProportionally
        return sv
    }()
    private lazy var nameTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Логин"
        tf.borderStyle = .roundedRect
        return tf
    }()
    
    private lazy var passwordTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Пароль"
        tf.borderStyle = .roundedRect
        return tf
    }()
    
    private lazy var authButton: UIButton = {
       let button = UIButton()
        button.configuration = .filled()
        button.configuration?.title = "Войти"
        button.addTarget(self, action: #selector(authButtonDidTap), for: .touchUpInside)
        return button
    }()
    
    private lazy var authInfoLabel: UILabel = {
       let label = UILabel()
        label.text = "Ошибка аунтефикации"
        label.textAlignment = .center
        label.textColor = .red
        return label
    }()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBackground
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Private methods

private extension LoginView {
    @objc
    private func authButtonDidTap() {}
}

// MARK: - Constraints

private extension LoginView {
    func commonInit() {
        setupSubviews()
        setupConstraints()
    }
    
    func setupSubviews() {
        addSubview(stackView)
    }
    
    func setupConstraints() {
        nameTextField.snp.makeConstraints { make in
            make.height.equalTo(44)
        }
        
        stackView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.horizontalEdges.equalToSuperview().inset(16)
        }
    }
}
