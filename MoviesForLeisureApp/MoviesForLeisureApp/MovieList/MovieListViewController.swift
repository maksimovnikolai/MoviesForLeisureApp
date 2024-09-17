//
//  MovieListViewController.swift
//  MoviesForLeisureApp
//
//  Created by Nikolai Maksimov on 11.09.2024.
//

import UIKit
import SnapKit

protocol MovieListViewProtocol: AnyObject {
    func update(with state: MovieListViewController.State)
}

final class MovieListViewController: UIViewController {
    // MARK: - MovieListViewDelegate
    
    weak var delegate: MovieListViewDelegate? {
        get { customView.delegate }
        set { customView.delegate = newValue }
    }
    
    // MARK: - Private properties
    
    private let viewModel: MovieListViewModelProtocol
    private let customView = MovieListView()
    
    // MARK: Init
    
    init(viewModel: MovieListViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life cycle
    
    override func loadView() {
        view = customView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        commonInit()
        viewModel.viewLoaded()
    }
}

// MARK: - Private methods

private extension MovieListViewController {
    func commonInit() {
        navigationItem.title = "Movies"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
}

// MARK: - MovieListViewProtocol
extension MovieListViewController: MovieListViewProtocol {
    func update(with state: State) {
        customView.configure(with: state)
    }
}

// MARK: Model

extension MovieListViewController {
    typealias State = MovieListView.State
}
