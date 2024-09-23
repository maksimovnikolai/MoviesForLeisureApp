//
//  MovieDetailsViewController.swift
//  MoviesForLeisureApp
//
//  Created by Nikolai Maksimov on 23.09.2024.
//

import UIKit
import SnapKit

final class MovieDetailsViewController: UIViewController {
    
    // MARK: - Private properties
    
    private var viewModel: MovieDetailsViewModelProtocol
    private let customView = MovieDetailsView()
    
    // MARK: - Init
    
    init(viewModel: MovieDetailsViewModelProtocol) {
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
        
    }
}
