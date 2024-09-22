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
    
    func configure(completion: @escaping(UIImageView) -> Void) {
        completion(posterImageView)
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
    }
    
    func setupConstraints() {
        posterImageView.snp.makeConstraints { make in
            make.horizontalEdges.verticalEdges.equalToSuperview()
        }
    }
}
