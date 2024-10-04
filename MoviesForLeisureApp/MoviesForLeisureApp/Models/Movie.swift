//
//  Movie.swift
//  MoviesForLeisureApp
//
//  Created by Nikolai Maksimov on 11.09.2024.
//

import Foundation

struct MovieDocsList: Decodable, Hashable {
    let docs: [Movie]
}

struct Movie: Decodable, Hashable {
    let id: Int
    let name: String
    let year: Int?
    let description: String?
    let rating: Rating
    let poster: Poster?
    let genres: [Genre]
    let persons: [Person]
}

struct Rating: Decodable, Hashable {
    let imdb: Double
}

struct Poster: Decodable, Hashable {
    let url: String
    let previewUrl: String
}

struct Genre: Decodable, Hashable {
    let name: String
}

struct Person: Decodable, Hashable {
    let id: Int
    let photo: String
    let name: String?
}
