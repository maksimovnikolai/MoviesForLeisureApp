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
        imageView.backgroundColor = .blue
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private lazy var actorNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Actor Name"
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

// MARK: - Private methods

private extension ActorsViewCell {
    private func configureImageView() {
        layoutIfNeeded()
        actorImageView.layer.cornerRadius = actorImageView.bounds.size.width / 2
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
