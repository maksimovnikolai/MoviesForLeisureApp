//
//  ApplicationCoordinator.swift
//  MoviesForLeisureApp
//
//  Created by Nikolai Maksimov on 13.10.2024.
//

import Foundation

final class ApplicationCoordinator: BaseCoordinator {
    
    private let router: RouterProtocol
    private let coordinatorFactory: CoordinatorFactoryProtocol
    
    init(router: RouterProtocol, coordinatorFactory: CoordinatorFactoryProtocol) {
        self.router = router
        self.coordinatorFactory = coordinatorFactory
    }
    
    // TODO: реализовать логику загрузки приложения
    override func start() {}
}
