//
//  MovieDetailsFactory.swift
//  MoviesForLeisureApp
//
//  Created by Nikolai Maksimov on 23.09.2024.
//

import UIKit

protocol MovieDetailsFactoryProtocol {
    func createMovieDetails(_ movie: Movie) -> UIViewController
}

final class MovieDetailsFactory: MovieDetailsFactoryProtocol {
    func createMovieDetails(_ movie: Movie) -> UIViewController {
        let viewModel = MovieDetailsViewModel(movie: movie)
        let controller = MovieDetailsViewController(viewModel: viewModel)
        viewModel.view = controller
        controller.delegate = viewModel
        return controller
    }
}
