//
//  RatingAndTrailerButtonView.swift
//  MoviesForLeisureApp
//
//  Created by Nikolai Maksimov on 26.09.2024.
//

import UIKit
import SnapKit

protocol RatingAndTrailerButtonViewDelegate: AnyObject {
    func showTrailer()
    func showMovie()
}

final class RatingAndTrailerButtonView: UIView {
    // MARK: Delegate
    
    weak var delegate: RatingAndTrailerButtonViewDelegate?
    
    // MARK: - UI components
    
    private lazy var mainStackView: UIStackView = makeStackView(
        spacing: 20,
        distribution: .fill,
        subviews: [labelsStackView, buttonsStackView]
    )
    
    private lazy var labelsStackView = makeStackView(
        spacing: 10,
        distribution: .equalSpacing,
        subviews: [yearLabel, ratingLabel, genreLabel]
    )
    
    private lazy var buttonsStackView = makeStackView(
        spacing: 5,
        distribution: .fillProportionally,
        subviews: [showTrailerButton, showMovieButton]
    )
    
    private lazy var yearLabel: UILabel = makeLabel()
    private lazy var ratingLabel: UILabel = makeLabel()
    private lazy var genreLabel: UILabel = makeLabel()

    private lazy var showTrailerButton: UIButton = makeButton(
        with: "Смотреть трейлер",
        action: #selector(showTrailer)
    )
    
    private lazy var showMovieButton: UIButton = makeButton(
        with: "Смотреть фильм",
        action: #selector(showMovie)
    )
    
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

extension RatingAndTrailerButtonView {
    func configure(with model: Model) {
        yearLabel.text = "Год: \(model.year)"
        ratingLabel.text = "Рейтинг: \(model.rating)"
        genreLabel.text = "Жанр:\n\(model.genre)"
    }
}

// MARK: - Model

extension RatingAndTrailerButtonView {
    struct Model {
        let year: String
        let rating: String
        let genre: String
    }
}

// MARK: - Private methods

private extension RatingAndTrailerButtonView {
    @objc
    func showTrailer() {
        delegate?.showTrailer()
    }
    
    @objc
    func showMovie() {
        delegate?.showMovie()
    }
    
    func makeStackView(spacing: CGFloat, distribution: UIStackView.Distribution, subviews: [UIView]) -> UIStackView {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = spacing
        stackView.distribution = distribution
        subviews.forEach {
            stackView.addArrangedSubview($0)
        }
        return stackView
    }
    
    func makeLabel() -> UILabel {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .preferredFont(forTextStyle: .headline)
        return label
    }
    
    func makeButton(with title: String, action: Selector) -> UIButton {
        let button = UIButton()
        button.configuration = .filled()
        button.configuration?.title = title
        button.addTarget(self, action: action, for: .touchUpInside)
        return button
    }
}

// MARK: - Constraints

private extension RatingAndTrailerButtonView {
    func commonInit() {
        setupSubviews()
        setupConstraints()
    }
    
    func setupSubviews() {
        addSubview(mainStackView)
    }
    
    func setupConstraints() {
        [showTrailerButton, showMovieButton].forEach {
            $0.snp.makeConstraints { make in
                make.height.equalTo(44)
            }
        }
        
        mainStackView.snp.makeConstraints { make in
            make.verticalEdges.equalToSuperview()
            make.trailing.equalToSuperview()
        }
    }
}
