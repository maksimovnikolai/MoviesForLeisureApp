//
//  MovieListFactory.swift
//  MoviesForLeisureApp
//
//  Created by Nikolai Maksimov on 16.09.2024.
//

import UIKit

protocol MovieListFactoryProtocol {
    func createModule() -> UIViewController
}

struct MovieListFactory: MovieListFactoryProtocol {
    func createModule() -> UIViewController {
        let networkManager = NetworkManager()
        let viewModel = MovieListViewModel(networkManager: networkManager)
        let viewController = MovieListViewController(viewModel: viewModel)
        viewModel.view = viewController
        viewController.delegate = viewModel
        return viewController
    }
}
