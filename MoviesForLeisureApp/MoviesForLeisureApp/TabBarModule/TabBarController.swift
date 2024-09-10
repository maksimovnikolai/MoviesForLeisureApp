//
//  TabBarController.swift
//  MoviesForLeisureApp
//
//  Created by Nikolai Maksimov on 10.09.2024.
//

import UIKit

final class TabBarController: UITabBarController {
    
    // MARK: - Private properties
    private lazy var movieList = createRoot(
        controller: UIViewController(),
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
        setViewControllers([movieList], animated: true)
    }
    
    func createRoot(
        controller: UIViewController,
        withTitle title: String,
        andSystemImage name: String
    ) -> UINavigationController {
        controller.title = title
        controller.tabBarItem.image = UIImage(systemName: name)
        return UINavigationController(rootViewController: controller)
    }
}
