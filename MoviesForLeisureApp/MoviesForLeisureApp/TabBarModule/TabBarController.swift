//
//  TabBarController.swift
//  MoviesForLeisureApp
//
//  Created by Nikolai Maksimov on 10.09.2024.
//

import UIKit

final class TabBarController: UITabBarController {
    
    // MARK: - Private properties
    
    private lazy var movieListModule = configureMovieListModule(
        controller: MovieListFactory().build(),
        withTitle: "Movie list",
        andSystemImage: "play.house"
    )
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        commonInit()
    }
}

// MARK: - Private methods

private extension TabBarController {
    func commonInit() {
        setViewControllers([movieListModule], animated: true)
    }
    
    func configureMovieListModule(
        controller: UIViewController,
        withTitle title: String,
        andSystemImage name: String
    ) -> UIViewController {
        controller.title = title
        controller.tabBarItem.image = UIImage(systemName: name)
        return controller
    }
}
