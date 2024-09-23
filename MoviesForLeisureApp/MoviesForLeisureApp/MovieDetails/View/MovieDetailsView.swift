//
//  MovieDetailsView.swift
//  MoviesForLeisureApp
//
//  Created by Nikolai Maksimov on 23.09.2024.
//

import UIKit
import SnapKit

final class MovieDetailsView: UIView {

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

private extension MovieDetailsView {
    func commonInit() {
        setupSubviews()
        setupConstraints()
    }
    
    func setupSubviews() {

    }
    
    func setupConstraints() {
     
    }
}
