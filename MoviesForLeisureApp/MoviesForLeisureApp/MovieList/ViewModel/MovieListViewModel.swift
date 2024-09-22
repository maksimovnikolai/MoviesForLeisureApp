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
    private var cacheManager: ImageCacheManagerProtocol
    private var movies: [Movie] = []
    
    // MARK: - Init
    init(networkManager: NetworkManagerProtocol, cacheManager: ImageCacheManagerProtocol) {
        self.networkManager = networkManager
        self.cacheManager = cacheManager
    }
}

// MARK: - MovieListViewModelProtocol

extension MovieListViewModel: MovieListViewModelProtocol {
    func viewLoaded() {
        fetchMovies()
    }
}

// MARK: - MovieListViewDelegate

extension MovieListViewModel: MovieListViewDelegate {
    func getImageData(from url: URL, completion: @escaping(Result<Data, Error>) -> Void) {
        if let cacheImageData = cacheManager.loadImageDataFromCache(from: url) {
            completion(.success(cacheImageData))
            return
        }
        networkManager.fetchImage(from: url) { [weak self] result in
            switch result {
            case let .success(imageData):
                self?.cacheManager.saveToCache(imageData: imageData, forKey: url)
                completion(.success(imageData))
            case let .failure(error):
                print(error)
            }
        }
    }
}

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
        let movieListModel = MovieListView.Model(movies: movies)
        view?.update(with: .success(movieListModel))
    }
}
