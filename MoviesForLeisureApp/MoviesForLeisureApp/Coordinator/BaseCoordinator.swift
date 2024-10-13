//
//  BaseCoordinator.swift
//  MoviesForLeisureApp
//
//  Created by Nikolai Maksimov on 13.10.2024.
//

import Foundation

protocol CoordinatorProtocol: AnyObject {
    func start()
}

class BaseCoordinator: CoordinatorProtocol {
    var childCoordinators: [CoordinatorProtocol] = []
    func start() {}
    
    func addDependency(_ coordinator: CoordinatorProtocol) {
        guard !childCoordinators.contains(where: { $0 === coordinator }) else { return }
        childCoordinators.append(coordinator)
    }
    
    func removeDependency(_ coordinator: CoordinatorProtocol?) {
        guard childCoordinators.isEmpty == false, let coordinator = coordinator else { return }
        
        if let coordinator = coordinator as? BaseCoordinator, !coordinator.childCoordinators.isEmpty {
            coordinator.childCoordinators
                .filter({ $0 !== coordinator })
                .forEach({ coordinator.removeDependency($0) })
        }
        for (index, element) in childCoordinators.enumerated() where element === coordinator {
            childCoordinators.remove(at: index)
            break
        }
    }
}
