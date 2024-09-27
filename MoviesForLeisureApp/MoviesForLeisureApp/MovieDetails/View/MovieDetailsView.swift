//
//  MovieDetailsView.swift
//  MoviesForLeisureApp
//
//  Created by Nikolai Maksimov on 23.09.2024.
//

import UIKit
import SnapKit

protocol MovieDetailsViewDelegate: RatingAndTrailerButtonViewDelegate {}

final class MovieDetailsView: UIView {
    weak var delegate: MovieDetailsViewDelegate? {
        didSet {
            buttonsView.delegate = delegate
        }
    }
    
    // MARK: - UI components
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        return scrollView
    }()
    
    private lazy var mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 10
        stackView.axis = .vertical
        return stackView
    }()
    
    private lazy var horizontalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 10
        return stackView
    }()
    
    private let posterView = MoviePosterView()
    private let buttonsView = RatingAndTrailerButtonView()
    private let actorsHeaderView = ActorsSectionHeaderView()
    private let actorsView = ActorsView()
    private let descriptionView = MovieDescriptionView()

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

// MARK: - Private methods

private extension MovieDetailsView {
    func configureMainStackView() {
        [horizontalStackView, actorsHeaderView, actorsView, descriptionView].forEach {
            mainStackView.addArrangedSubview($0)
        }
    }
    
    func configureHorizontalStackView() {
        [posterView, buttonsView].forEach {
            horizontalStackView.addArrangedSubview($0)
        }
    }
}

// MARK: - Constraints

private extension MovieDetailsView {
    func commonInit() {
        backgroundColor = .systemBackground
        configureHorizontalStackView()
        configureMainStackView()
        setupSubviews()
        setupConstraints()
    }
    
    func setupSubviews() {
        addSubview(scrollView)
        scrollView.addSubview(mainStackView)
    }
    
    func setupConstraints() {
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalTo(safeAreaLayoutGuide)
            make.width.equalTo(mainStackView.snp.width)
        }
        
        actorsView.snp.makeConstraints { make in
            make.height.equalTo(130)
        }
        
        posterView.snp.makeConstraints { make in
            make.height.equalTo(250)
        }
        
        mainStackView.snp.makeConstraints { make in
            make.horizontalEdges.verticalEdges.equalTo(scrollView)
        }
    }
}
