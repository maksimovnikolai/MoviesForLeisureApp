//
//  MovieDetailsView.swift
//  MoviesForLeisureApp
//
//  Created by Nikolai Maksimov on 23.09.2024.
//

import UIKit
import SnapKit

final class MovieDetailsView: UIView {
    // MARK: - UI components
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        return scrollView
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 10
        stackView.axis = .vertical
        return stackView
    }()
    
    private let posterView = MoviePosterView()
    private var descriptionView = MovieDescriptionView()

    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - ViewModelConfigurable

extension MovieDetailsView {
    func configure(with model: Model) {
        descriptionView.configure(title: model.movieTitle, description: model.movieDescription)
    }
}

// MARK: - Model

extension MovieDetailsView {
    struct Model {
        var movieTitle: String
        var movieDescription: String
    }
}

// MARK: - CommonInitProtocol

extension MovieDetailsView: CommonInitProtocol {
    func commonInit() {
        backgroundColor = .systemBackground
        setupSubviews()
        setupConstraints()
    }
    
    func setupSubviews() {
        [posterView, descriptionView].forEach { stackView.addArrangedSubview($0) }
        addSubview(scrollView)
        scrollView.addSubview(stackView)
    }
    
    func setupConstraints() {
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalTo(safeAreaLayoutGuide)
            make.width.equalTo(stackView.snp.width)
        }
        
        stackView.snp.makeConstraints { make in
            make.horizontalEdges.verticalEdges.equalTo(scrollView)
        }
        
        posterView.snp.makeConstraints { make in
            make.height.equalTo(250)
        }
    }
}
