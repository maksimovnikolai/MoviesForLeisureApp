//
//  MovieListCell.swift
//  MoviesForLeisureApp
//
//  Created by Nikolai Maksimov on 12.09.2024.
//

import UIKit
import SnapKit

final class MovieListCell: UICollectionViewCell {
    static let identifier = "MovieListCell"
    
    // MARK: - UI Components
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.color = .systemGray
        activityIndicator.startAnimating()
        activityIndicator.hidesWhenStopped = true
        return activityIndicator
    }()
    
    private lazy var posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 15
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        // TODO: - добавить изображение по умолчанию, в случае отсутствия постера
        return imageView
    }()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
     
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(completion: @escaping(UIImageView, UIActivityIndicatorView) -> Void) {
        completion(posterImageView, activityIndicator)
    }
}

// MARK: - Private methods

private extension MovieListCell {
    func commonInit() {
        setupSubviews()
        setupConstraints()
    }
    
    func setupSubviews() {
        addSubview(posterImageView)
        addSubview(activityIndicator)
    }
    
    func setupConstraints() {
        activityIndicator.snp.makeConstraints { make in
            make.center.equalTo(posterImageView.snp.center)
        }
        
        posterImageView.snp.makeConstraints { make in
            make.horizontalEdges.verticalEdges.equalToSuperview()
        }
    }
}
