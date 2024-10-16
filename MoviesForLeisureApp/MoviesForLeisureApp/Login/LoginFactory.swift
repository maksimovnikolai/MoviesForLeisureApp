//
//  LoginFactory.swift
//  MoviesForLeisureApp
//
//  Created by Nikolai Maksimov on 16.10.2024.
//

import UIKit

protocol LoginFactoryProtocol {
    func create() -> UIViewController
}

final class LoginFactory: LoginFactoryProtocol {
    func create() -> UIViewController {
        let viewModel = LoginViewModel()
        let controller = LoginViewController(viewModel: viewModel)
        return controller
    }
}
