//
//  MoviePosterView.swift
//  MoviesForLeisureApp
//
//  Created by Nikolai Maksimov on 25.09.2024.
//

import UIKit
import SnapKit

final class MoviePosterView: UIView {
    // MARK: - UI components
    
    private var posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 15
        imageView.backgroundColor = .red
        return imageView
    }()
    
    // TODO: - Добавить справа от постера: rating, year, youtube trailer button
    
    // MARK: - Init
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - CommonInitProtocol

extension MoviePosterView: CommonInitProtocol {
    func commonInit() {
        setupSubviews()
        setupConstraints()
    }
    
    func setupSubviews() {
        addSubview(posterImageView)
    }
    
    func setupConstraints() {
        let width = (UIScreen.main.bounds.width / 2) - 20
        posterImageView.snp.makeConstraints { make in
            make.top.equalTo(snp.top).offset(10)
            make.bottom.equalTo(snp.bottom).inset(10)
            make.leading.equalToSuperview().inset(16)
            make.width.equalTo(width)
        }
    }
}
