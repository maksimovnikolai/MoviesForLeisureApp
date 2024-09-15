//
//  NetworkManager.swift
//  MoviesForLeisureApp
//
//  Created by Nikolai Maksimov on 11.09.2024.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case badURLWithComponents
    case invalidData
    case decodingError
    case componentsError
}

final class NetworkManager {
    static let shared = NetworkManager()
    
    // MARK: - Private Init
    
    private init() {}
    
    // MARK: - Fetch movies
    
    func fetchMovies() async throws -> MovieDocsList {
        guard let url = URL(string: MovieAPI.baseURL) else {
            throw NetworkError.invalidURL
        }
        
        guard var components = URLComponents(url: url, resolvingAgainstBaseURL: true) else {
            throw NetworkError.componentsError
        }
        
        let queryItems = getQueryItems()
        components.queryItems = components.queryItems.map { $0 + queryItems } ?? queryItems
        guard let urlWithComponents = components.url else {
            throw NetworkError.badURLWithComponents
        }
        
        let request = configureRequest(with: urlWithComponents)
        let (data, _) = try await URLSession.shared.data(for: request)
        
        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let data = try decoder.decode(MovieDocsList.self, from: data)
            return data
        } catch {
            throw NetworkError.decodingError
        }
    }
    
    // MARK: - Fetch image
    
    func fetchPoster(from url: String) async throws -> Data {
        guard let url = URL(string: url) else {
            throw NetworkError.invalidURL
        }
        return try Data(contentsOf: url)
    }
}

// MARK: - Private methods

private extension NetworkManager {
    func configureRequest(with url: URL) -> URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.timeoutInterval = 10
        request.allHTTPHeaderFields = [
            "Content-Type": "application/json",
            MovieAPI.key: MovieAPI.token
        ]
        return request
    }
    
    func getQueryItems() -> [URLQueryItem] {
        [
            URLQueryItem(name: "page", value: "1"),
            URLQueryItem(name: "limit", value: "20"),
            URLQueryItem(name: "notNullFields", value: "name"),
            URLQueryItem(name: "notNullFields", value: "poster.url"),
            URLQueryItem(name: "notNullFields", value: "genres.name"),
            URLQueryItem(name: "notNullFields", value: "type"),
        ]
    }
}
