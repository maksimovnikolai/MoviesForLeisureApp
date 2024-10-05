//
//  ActorsViewCell.swift
//  MoviesForLeisureApp
//
//  Created by Nikolai Maksimov on 27.09.2024.
//

import UIKit
import SnapKit

final class ActorsViewCell: UICollectionViewCell {
    static let identifier = "ActorsViewCell"
    
    // MARK: - UI components
    
    private lazy var actorImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private lazy var actorNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Actor Name"
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
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

extension ActorsViewCell {
    func configure(with model: Model?) {
        if let model {
            actorNameLabel.text = model.actorName
            setupActorImage(from: model.actorImageURL)
        }
    }
}

// MARK: - Model
extension ActorsViewCell {
    struct Model {
        let actorName: String
        let actorImageURL: String
    }
}

// MARK: - Private methods

private extension ActorsViewCell {
    func configureImageView() {
        layoutIfNeeded()
        actorImageView.layer.cornerRadius = actorImageView.bounds.size.width / 2
    }
    
    func setupActorImage(from urlString: String) {
        guard let url = URL(string: urlString) else { return }
        DispatchQueue.global().async {
            guard let imageData = try? Data(contentsOf: url) else { return }
            DispatchQueue.main.async {
                self.actorImageView.image = UIImage(data: imageData)
            }
        }
    }
}

// MARK: - Constraints

private extension ActorsViewCell {
    func commonInit() {
        setupSubviews()
        setupConstraints()
        configureImageView()
    }
    
    func setupSubviews() {
        addSubview(actorImageView)
        addSubview(actorNameLabel)
    }
    
    func setupConstraints() {
        actorImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(5)
            make.leading.trailing.equalToSuperview().inset(5)
            make.height.equalTo(actorImageView.snp.width)
        }
        
        actorNameLabel.snp.makeConstraints { make in
            make.top.equalTo(actorImageView.snp.bottom).offset(5)
            make.leading.trailing.equalToSuperview()
        }
    }
}
