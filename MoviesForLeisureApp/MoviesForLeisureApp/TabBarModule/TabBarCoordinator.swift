//
//  TabBarCoordinator.swift
//  MoviesForLeisureApp
//
//  Created by Nikolai Maksimov on 18.10.2024.
//

import Foundation

final class TabBarCoordinator: BaseCoordinator {
    // TODO: Доработать координатор
    
    private let router: RouterProtocol
    
    init(router: RouterProtocol) {
        self.router = router
    }
    
    override func start() {
        showTabBar()
    }
    
    private func showTabBar() {
        let tabBar = TabBarFactory().create(router: router)
        router.setRootModule(tabBar, hideBar: false)
    }
}
