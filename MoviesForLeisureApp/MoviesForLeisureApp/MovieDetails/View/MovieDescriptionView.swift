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
    
    private lazy var movieNameLabel: UILabel = getLabel()
    private lazy var movieDescriptionLabel: UILabel = getLabel()
    private lazy var stackView: UIStackView = getStackView()
    
    // MARK: Init
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(title: String, description: String) {
        movieNameLabel.text = "Название:\n\(title)"
        movieDescriptionLabel.text = "Сюжет:\n\(description)"
    }
}

// MARK: - CommonInitProtocol

extension MovieDescriptionView: CommonInitProtocol {
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
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().inset(16)
        }
    }
}

// MARK: - Private methods

private extension MovieDescriptionView {
    func getStackView() -> UIStackView {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 10
        [movieNameLabel, movieDescriptionLabel].forEach { stackView.addArrangedSubview($0) }
        return stackView
    }
    
    func getLabel() -> UILabel {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        return label
    }
}
