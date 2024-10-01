//
//  MovieDescriptionView.swift
//  MoviesForLeisureApp
//
//  Created by Nikolai Maksimov on 25.09.2024.
//

import UIKit
import SnapKit

final class MovieDescriptionView: UIView {
    // MARK: - UI components
    
    private lazy var stackView: UIStackView = getStackView()
    private lazy var movieDescriptionLabel: UILabel = getLabel()
    
    // MARK: Init
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - ViewModelConfigurable

extension MovieDescriptionView {
    func configure(model: Model) {
        movieDescriptionLabel.text = "Сюжет:\n\(model.description)"
    }
}

// MARK: - Model

extension MovieDescriptionView {
    struct Model {
        let description: String
    }
}

// MARK: - Private methods

private extension MovieDescriptionView {
    func getStackView() -> UIStackView {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 10
        [movieDescriptionLabel].forEach { stackView.addArrangedSubview($0) }
        return stackView
    }
    
    func getLabel() -> UILabel {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        return label
    }
}

// MARK: - Constraints

private extension MovieDescriptionView {
    func commonInit() {
        setupSubviews()
        setupConstraints()
    }
    
    func setupSubviews() {
        addSubview(stackView)
    }
    
    func setupConstraints() {
        stackView.snp.makeConstraints { make in
            make.verticalEdges.equalToSuperview()
            make.leading.trailing.equalToSuperview()
        }
    }
}
