//
//  LoginViewController.swift
//  MoviesForLeisureApp
//
//  Created by Nikolai Maksimov on 16.10.2024.
//

import UIKit

final class LoginViewController: UIViewController {

    // MARK: - Private properties
    
    private let viewModel: LoginViewModelProtocol
    private let loginView = LoginView()
    
    // MARK: - Init
    
    init(viewModel: LoginViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life cycle
    
    override func loadView() {
        view = loginView
    }
}
