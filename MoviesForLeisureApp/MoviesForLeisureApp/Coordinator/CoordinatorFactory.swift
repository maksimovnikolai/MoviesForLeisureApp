//
//  CoordinatorFactory.swift
//  MoviesForLeisureApp
//
//  Created by Nikolai Maksimov on 13.10.2024.
//

import Foundation

protocol CoordinatorFactoryProtocol {
    func makeApplicationCoordinator(router: RouterProtocol) -> ApplicationCoordinator
}

final class CoordinatorFactory: CoordinatorFactoryProtocol {
    func makeApplicationCoordinator(router: RouterProtocol) -> ApplicationCoordinator {
        ApplicationCoordinator(router: router, coordinatorFactory: self)
    }
}
