//
//  CoordinatorFactory.swift
//  MoviesForLeisureApp
//
//  Created by Nikolai Maksimov on 13.10.2024.
//

import Foundation

protocol CoordinatorFactoryProtocol {
    func makeApplicationCoordinator(router: RouterProtocol) -> ApplicationCoordinator
    func makeLoginCoordinator(router: RouterProtocol) -> LoginCoordinator
    func makeTabBarCoordinator(router: RouterProtocol) -> TabBarCoordinator
}

final class CoordinatorFactory: CoordinatorFactoryProtocol {
    func makeApplicationCoordinator(router: RouterProtocol) -> ApplicationCoordinator {
        ApplicationCoordinator(router: router, coordinatorFactory: self)
    }
    
    func makeLoginCoordinator(router: RouterProtocol) -> LoginCoordinator {
        LoginCoordinator(router: router)
    }
    
    func makeTabBarCoordinator(router: RouterProtocol) -> TabBarCoordinator {
        TabBarCoordinator(router: router)
    }
}
