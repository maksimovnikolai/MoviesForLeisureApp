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
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }()
    
    private lazy var mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 10
        stackView.axis = .vertical
        return stackView
    }()
    
    private lazy var titleStackView: UIStackView = makeStackView(with: .vertical, spacing: 0)
    
    private lazy var titleLabel: UILabel = {
       let label = UILabel()
        label.text = "Movie TITLE"
        label.font = .systemFont(ofSize: 24)
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var horizontalStackView: UIStackView = makeStackView(with: .horizontal, spacing: 10)
    private let posterView = MoviePosterView()
    private let buttonsView = RatingAndTrailerButtonView()
    
    private lazy var verticalStackView: UIStackView = makeStackView(with: .vertical, spacing: 0)
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
        titleLabel.text = model.movieTitle
        posterView.configure(with: model.posterViewModel)
        descriptionView.configure(model: model.descriptionViewModel)
        buttonsView.configure(with: model.ratingAndYearViewModel)
    }
}

// MARK: - Model

extension MovieDetailsView {
    struct Model {
        let movieTitle: String
        let posterViewModel: MoviePosterView.Model
        let descriptionViewModel: MovieDescriptionView.Model
        let ratingAndYearViewModel: RatingAndTrailerButtonView.Model
    }
}

// MARK: - Private methods

private extension MovieDetailsView {
    func makeStackView(with axis: NSLayoutConstraint.Axis, spacing: CGFloat) -> UIStackView {
        let stackView = UIStackView()
        stackView.axis = axis
        stackView.spacing = spacing
        stackView.layoutMargins = .init(top: 0, left: 16, bottom: 0, right: 16)
        stackView.isLayoutMarginsRelativeArrangement = true
        return stackView
    }
    
    func configureTitleStackView() {
        titleStackView.addArrangedSubview(titleLabel)
    }
    
    func configureMainStackView() {
        [titleStackView, horizontalStackView, verticalStackView].forEach {
            mainStackView.addArrangedSubview($0)
        }
    }
    
    func configureHorizontalStackView() {
        [posterView, buttonsView].forEach {
            horizontalStackView.addArrangedSubview($0)
        }
    }
    
    func configureVerticalStackView() {
        [actorsHeaderView, actorsView, descriptionView].forEach {
            verticalStackView.addArrangedSubview($0)
        }
    }
}

// MARK: - Constraints

private extension MovieDetailsView {
    func commonInit() {
        backgroundColor = .systemBackground
        configureTitleStackView()
        configureVerticalStackView()
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
