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
        let viewModel = MovieDetailsViewModel()
        let controller = MovieDetailsViewController(viewModel: viewModel)
        
        return controller
    }
}
