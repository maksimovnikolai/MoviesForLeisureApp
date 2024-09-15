//
//  MovieListViewController.swift
//  MoviesForLeisureApp
//
//  Created by Nikolai Maksimov on 11.09.2024.
//

import UIKit
import SnapKit

final class MovieListViewController: UIViewController {

    // MARK: - Private properties
   private let customView = MovieListView()
    
    override func loadView() {
        view = customView
    }
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        commonInit()
    }
}

// MARK: - Private methods

private extension MovieListViewController {
    func commonInit() {
        navigationItem.title = "Movies"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
}
