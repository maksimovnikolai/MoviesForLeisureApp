//
//  NetworkManager.swift
//  MoviesForLeisureApp
//
//  Created by Nikolai Maksimov on 11.09.2024.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError
    case componentsError
    case badURLWithComponents
}

protocol NetworkManagerProtocol {
    func fetchMovies() async throws -> MovieDocsList
    func fetchImage(from url: URL, completion: @escaping(Result<Data, NetworkError>) -> Void)
}

final class NetworkManager: NetworkManagerProtocol {
    // MARK: - Fetch movies
    
    func fetchMovies() async throws -> MovieDocsList {
        guard let url = URL(string: APIHelper.moviesURL) else { throw NetworkError.invalidURL }
        
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
    
    func fetchImage(from url: URL, completion: @escaping(Result<Data, NetworkError>) -> Void) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data else {
                completion(.failure(.noData))
                return
            }
            DispatchQueue.main.async {
                completion(.success(data))
            }
        }.resume()
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
            URLQueryItem(name: "limit", value: "30"),
        ]
    }
}
