//
//  MovieListViewModel.swift
//  MoviesForLeisureApp
//
//  Created by Nikolai Maksimov on 11.09.2024.
//

import Foundation

protocol MovieListViewModelProtocol: AnyObject {
    func viewLoaded()
}

final class MovieListViewModel {
    // MARK: - MovieListViewProtocol
    
    weak var view: MovieListViewProtocol?
    
    // MARK: - Private properties
    private var networkManager: NetworkManagerProtocol
    private var movies: [Movie] = []
    
    // MARK: - Init
    init(networkManager: NetworkManagerProtocol) {
        self.networkManager = networkManager
    }
}

// MARK: - MovieListViewModelProtocol

extension MovieListViewModel: MovieListViewModelProtocol {
    func viewLoaded() {
        fetchMovies()
    }
}

// MARK: - MovieListViewDelegate

extension MovieListViewModel: MovieListViewDelegate {}

// MARK: - Private methods

private extension MovieListViewModel {
    func fetchMovies() {
        Task {
            do {
                movies = try await networkManager.fetchMovies().docs
                updateView()
            } catch NetworkError.invalidURL {
                print("invalidURL")
            } catch NetworkError.decodingError {
                print("decodingError")
            } catch {
                print("don't now what the problem")
            }
        }
    }
    
    func updateView() {
        let viewModel = MovieListView.Model(movies: movies)
        view?.update(with: .success(viewModel))
    }
}
