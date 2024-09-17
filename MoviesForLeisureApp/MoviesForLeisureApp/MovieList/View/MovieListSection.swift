//
//  MovieListSection.swift
//  MoviesForLeisureApp
//
//  Created by Nikolai Maksimov on 16.09.2024.
//

import Foundation

enum SectionKind: Int, CaseIterable {
    case movie
    case tvSeries
    case cartoon
    
    var engTitle: String {
        switch self {
        case .movie:
            return "movie"
        case .tvSeries:
            return "tv-series"
        case .cartoon:
            return "cartoon"
        }
    }
}
