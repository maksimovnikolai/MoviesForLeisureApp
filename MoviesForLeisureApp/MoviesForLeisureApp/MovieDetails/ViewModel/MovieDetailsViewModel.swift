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
    
    func configureActorsCellViewModel(at indexPath: IndexPath) -> ActorsViewCell.Model {
        actorsViewCellModel(at: indexPath)
    }
    
    func numbersOfItemInSection() -> Int {
        movie.persons.count
    }
}

// MARK: - MovieDetailsViewModelProtocol

extension MovieDetailsViewModel: MovieDetailsViewModelProtocol {
    func viewLoaded() {
        updateView()
    }
}

// MARK: - Private methods

private extension MovieDetailsViewModel {
    func getMoviePosterURL() -> URL? {
        // TODO: - загружать изображение из кеша, а случае его отсутствия, выполнять запрос
        guard let url = URL(string: movie.poster?.url ?? "") else { return nil }
        return url
    }
    
    func actorsViewCellModel(at indexPath: IndexPath) -> ActorsViewCell.Model {
        let actorName = movie.persons[indexPath.item].name ?? ""
        // TODO: - реализовать загрузку изображения актера
        let imageData = Data()
        return ActorsViewCell.Model(
            actorName: actorName,
            actorImageData: imageData
        )
    }
    
    func updateView() {
        let posterViewModel = MoviePosterView.Model(imageURL: getMoviePosterURL()!)
        let movieDescriptionViewModel = MovieDescriptionView.Model(
            description: movie.description ?? ""
        )
        let movieRatingAndYearViewModel = RatingAndTrailerButtonView.Model(
            year: "\(movie.year ?? 0)",
            rating: "\(movie.rating?.imdb ?? 0.00)",
            genre: movie.genres.first?.name ?? "-"
        )
        let detailsViewModel = MovieDetailsView.Model(
            movieTitle: movie.name,
            posterViewModel: posterViewModel,
            descriptionViewModel: movieDescriptionViewModel,
            ratingAndYearViewModel: movieRatingAndYearViewModel
        )
        view?.update(with: detailsViewModel)
    }
}
