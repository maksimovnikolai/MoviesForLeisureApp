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
    
    // TODO: -
    // добавить дефолтное изображение, для случая ошибки загрузки постера
    
    private lazy var activityIndicatorView: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.hidesWhenStopped = true
        return indicator
    }()
    
    private lazy var posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 15
        imageView.backgroundColor = .red
        return imageView
    }()
    
    // MARK: - Init
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        activityIndicatorView.startAnimating()
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - ViewModelConfigurable

extension MoviePosterView {
    func configure(with model: Model) {
        convertAndSetupPosterImage(from: model.imageURL)
    }
}

// MARK: - Model

extension MoviePosterView {
    struct Model {
        let imageURL: URL
    }
}

// MARK: - Private methods

private extension MoviePosterView {
    func convertAndSetupPosterImage(from url: URL) {
        DispatchQueue.global().async {
            let data = try? Data(contentsOf: url)
            DispatchQueue.main.async {
                if let data {
                    self.activityIndicatorView.stopAnimating()
                    self.posterImageView.image = UIImage(data: data)
                }
            }
        }
    }
}

// MARK: - Constraints

private extension MoviePosterView {
    func commonInit() {
        setupSubviews()
        setupConstraints()
    }
    
    func setupSubviews() {
        addSubview(posterImageView)
        posterImageView.addSubview(activityIndicatorView)
    }
    
    func setupConstraints() {
        let width = (UIScreen.main.bounds.width / 2) - 20
        posterImageView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
            make.width.equalTo(width)
        }
        
        activityIndicatorView.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
}
