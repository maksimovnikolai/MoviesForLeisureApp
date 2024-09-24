//
//  Router.swift
//  MoviesForLeisureApp
//
//  Created by Nikolai Maksimov on 23.09.2024.
//

import UIKit

protocol RouterHelperProtocol {
    var navigationController: UINavigationController? { get set }
}

protocol RouterProtocol: RouterHelperProtocol {
    func showMovieDetails(_ item: Movie)
}

final class Router: RouterProtocol {
    var navigationController: UINavigationController?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func showMovieDetails(_ item: Movie) {
        if let navigationController {
            let controller = MovieDetailsFactory().createMovieDetails(item)
            navigationController.pushViewController(controller, animated: true)
        }
    }
}
