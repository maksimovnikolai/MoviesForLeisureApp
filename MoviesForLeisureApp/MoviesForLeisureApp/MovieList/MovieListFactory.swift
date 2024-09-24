//
//  MovieListFactory.swift
//  MoviesForLeisureApp
//
//  Created by Nikolai Maksimov on 16.09.2024.
//

import UIKit

protocol MovieListFactoryProtocol {
    func build() -> UINavigationController
}

struct MovieListFactory: MovieListFactoryProtocol {
    func build() -> UINavigationController {
        let navController = UINavigationController()
        let networkManager = NetworkManager()
        let cacheManager = ImageCacheManager()
        let router = Router(navigationController: navController)
        
        let viewModel = MovieListViewModel(
            networkManager: networkManager,
            cacheManager: cacheManager, 
            router: router
        )
        let viewController = MovieListViewController(viewModel: viewModel)
        navController.setViewControllers([viewController], animated: true)
        viewModel.view = viewController
        viewController.delegate = viewModel
        return navController
    }
}
