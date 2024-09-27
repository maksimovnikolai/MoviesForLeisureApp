//
//  ActorsView.swift
//  MoviesForLeisureApp
//
//  Created by Nikolai Maksimov on 27.09.2024.
//

import UIKit
import SnapKit

final class ActorsView: UIView {
    // TODO: - написать логику обновления данных
    
    // MARK: - UI components
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = .init(width: 100, height: 130)
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(ActorsViewCell.self, forCellWithReuseIdentifier: ActorsViewCell.identifier)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.dataSource = self
        return collectionView
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

// MARK: - UICollectionViewDataSource

extension ActorsView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ActorsViewCell.identifier, for: indexPath) as? ActorsViewCell else {
            return UICollectionViewCell()
        }
        return cell
    }
}

// MARK: - Constraints

private extension ActorsView {
    func commonInit() {
        setupSubviews()
        setupConstraints()
    }
    
    func setupSubviews() {
        addSubview(collectionView)
    }
    
    func setupConstraints() {
        collectionView.snp.makeConstraints { make in
            make.verticalEdges.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(16)
        }
    }
}
