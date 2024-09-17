//
//  MovieListSectionHeaderView.swift
//  MoviesForLeisureApp
//
//  Created by Nikolai Maksimov on 15.09.2024.
//

import UIKit
import SnapKit

final class MovieListSectionHeaderView: UICollectionReusableView {
    static let identifier = "MovieListSectionHeaderView"
    
    // MARK: - UI Components
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .headline)
        return label
    }()
    
    private lazy var showAllMoviesButton: UIButton = {
       let button = UIButton()
        button.configuration = .plain()
        button.configuration?.title = "см.все"
        button.addTarget(self, action: #selector(buttonDidTap), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureHeaderView(with text: String) {
        titleLabel.text = text
    }
}

// MARK: - Private methods

private extension MovieListSectionHeaderView {
    func commonInit() {
        setupSubviews()
        setupConstraints()
    }
    
    func setupSubviews() {
        [titleLabel, showAllMoviesButton].forEach { addSubview($0) }
    }
    
    func setupConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16)
            make.bottom.equalToSuperview().inset(5)
        }
        
        showAllMoviesButton.snp.makeConstraints { make in
            make.right.bottom.equalToSuperview()
            make.width.equalTo(100)
        }
    }
    
    @objc
    func buttonDidTap() {}
}
