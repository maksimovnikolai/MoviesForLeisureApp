//
//  LoginCoordinator.swift
//  MoviesForLeisureApp
//
//  Created by Nikolai Maksimov on 16.10.2024.
//

import UIKit

final class LoginCoordinator: BaseCoordinator {
    var finishFlow: (() -> Void)?

    // MARK: - Private properties
    
    private let router: RouterProtocol
    
    // MARK: - Init
    
    init(router: RouterProtocol) {
        self.router = router
    }
    
    override func start() {
        showLogIn()
    }
    
    private func showLogIn() {
        let loginVC = LoginFactory().create()
        router.setRootModule(loginVC)
    }
}
