//
//  MovieDetailsViewModel.swift
//  MoviesForLeisureApp
//
//  Created by Nikolai Maksimov on 23.09.2024.
//

import Foundation

protocol MovieDetailsViewModelProtocol {
    func viewLoaded()
}

final class MovieDetailsViewModel {
    // MARK: Delegate
    
    weak var view: MovieDetailsViewProtocol?
    
    // MARK: - Private properties
    
    private var movie: Movie
    
    // MARK: - Init
    
    init(movie: Movie) {
        self.movie = movie
    }
}

// MARK: - MovieDetailsViewDelegate

extension MovieDetailsViewModel: MovieDetailsViewDelegate {
    // TODO: реализовать логику просмотра трейлера и фильма 
    func showTrailer() {}
    
    func showMovie() {}
}

// MARK: - MovieDetailsViewModelProtocol

extension MovieDetailsViewModel: MovieDetailsViewModelProtocol {
    func viewLoaded() {
        updateView()
    }
}

// MARK: - Private methods

private extension MovieDetailsViewModel {
    func updateView() {
        view?.update(with: .init(movieTitle: movie.name, movieDescription: movie.description ?? "- отсутствует"))
    }
}
