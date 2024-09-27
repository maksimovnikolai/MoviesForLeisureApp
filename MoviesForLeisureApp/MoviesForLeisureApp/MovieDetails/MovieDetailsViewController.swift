//
//  MovieDetailsViewController.swift
//  MoviesForLeisureApp
//
//  Created by Nikolai Maksimov on 23.09.2024.
//

import UIKit
import SnapKit

protocol MovieDetailsViewProtocol: AnyObject {
    func update(with model: MovieDetailsView.Model)
}

final class MovieDetailsViewController: UIViewController {
    weak var delegate: MovieDetailsViewDelegate? {
        get { customView.delegate }
        set { customView.delegate = newValue }
    }
    
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

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.viewLoaded()
        commonInit()
    }
}

// MARK: - MovieDetailsViewProtocol

extension MovieDetailsViewController: MovieDetailsViewProtocol {
    func update(with model: Model) {
        customView.configure(with: model)
    }
}

// MARK: - Model

extension MovieDetailsViewController {
    typealias Model = MovieDetailsView.Model
}

// MARK: - CommonInitProtocol

extension MovieDetailsViewController: CommonInitProtocol {
    func commonInit() {
        navigationController?.navigationBar.topItem?.backButtonTitle = ""
        navigationItem.title = "О фильме"
        setupSubviews()
        setupConstraints()
    }
    
    func setupSubviews() {
        view.addSubview(customView)
    }
    
    func setupConstraints() {
        customView.snp.makeConstraints { make in
            make.horizontalEdges.verticalEdges.equalToSuperview()
        }
    }
}
