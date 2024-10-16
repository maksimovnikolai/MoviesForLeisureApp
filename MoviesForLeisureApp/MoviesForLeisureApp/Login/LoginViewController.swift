//
//  LoginViewController.swift
//  MoviesForLeisureApp
//
//  Created by Nikolai Maksimov on 16.10.2024.
//

import UIKit

final class LoginViewController: UIViewController {

    // MARK: - Private properties
    
    private var loginView = LoginView()
    
    // MARK: - Life cycle
    
    override func loadView() {
        view = loginView
    }
}
