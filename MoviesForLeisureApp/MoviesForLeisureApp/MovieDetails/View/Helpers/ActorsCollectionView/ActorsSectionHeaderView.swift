//
//  ActorsSectionHeaderView.swift
//  MoviesForLeisureApp
//
//  Created by Nikolai Maksimov on 27.09.2024.
//

import UIKit
import SnapKit

final class ActorsSectionHeaderView: UIView {
    static let identifier = "ActorsSectionHeaderView"
    
    // MARK: - UI Components
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Актеры"
        label.font = .preferredFont(forTextStyle: .headline)
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

// MARK: - Constraints

private extension ActorsSectionHeaderView {
    func commonInit() {
        setupSubviews()
        setupConstraints()
    }
    
    func setupSubviews() {
       addSubview(titleLabel)
    }
    
    func setupConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.verticalEdges.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(16)
        }
    }
}
