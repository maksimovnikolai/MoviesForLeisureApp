//
//  MovieListView.swift
//  MoviesForLeisureApp
//
//  Created by Nikolai Maksimov on 11.09.2024.
//

import UIKit
import SnapKit

protocol MovieListViewDelegate: AnyObject {
    func getImageData(from url: URL, completion: @escaping(Result<Data, Error>) -> Void)
}

final class MovieListView: UIView {
    typealias DataSource = UICollectionViewDiffableDataSource<SectionKind, Movie>
    
    // MARK: - MovieListViewDelegate
    
    weak var delegate: MovieListViewDelegate?
    
    // MARK: - Private properties
    
    private var dataSource: DataSource!
    
    // MARK: - UI Components

    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: createLayout()
        )
        collectionView.register(
            MovieListCell.self,
            forCellWithReuseIdentifier: MovieListCell.identifier
        )
        collectionView.register(
            MovieListSectionHeaderView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: MovieListSectionHeaderView.identifier
        )
        return collectionView
    }()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        commonInit()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - ViewModelConfigurable

extension MovieListView {
    func configure(with state: State) {
        switch state {
        case let .success(model):
            configureSnapshot(with: model.movies)
        case let .failure(error):
            print(error)
        }
    }
}

// MARK: - Model

extension MovieListView {
    struct Model {
        var movies: [Movie]
    }
    
    enum State {
        case success(Model)
        case failure(Error)
    }
}

// MARK: - Private methods

private extension MovieListView {
    func commonInit() {
        configureDataSource()
        setupSubviews()
        setupConstraints()
    }
    
    func setupSubviews() {
        addSubview(collectionView)
    }
    
    func setupConstraints() {
        collectionView.snp.makeConstraints { make in
            make.horizontalEdges.verticalEdges.equalToSuperview()
        }
    }
    
    func configureSnapshot(with movies: [Movie]) {
        var snapshot = NSDiffableDataSourceSnapshot<SectionKind, Movie>()
        snapshot.appendSections([.movie])
        snapshot.appendItems(movies)
        dataSource.apply(snapshot)
    }
    
    func updateImage(with optionalPosterURL: URL?, posterImageView: UIImageView) {
        guard let posterURL = optionalPosterURL else { return }
        delegate?.getImageData(from: posterURL, completion: { result in
            switch result {
            case let .success(data):
                let image = UIImage(data: data)
                if posterURL == optionalPosterURL {
                    posterImageView.image = image
                }
            case let .failure(error):
                print(error.localizedDescription)
            }
        })
    }
}

// MARK: - Configure CollectionView DataSource

private extension MovieListView {
    func configureDataSource() {
        dataSource = DataSource(collectionView: collectionView, cellProvider: { collectionView, indexPath, item in
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: MovieListCell.identifier,
                for: indexPath
            ) as? MovieListCell else {
                return MovieListCell()
            }
            
            cell.configure { posterImageView in
                var posterURLL: URL? {
                    didSet {
                        posterImageView.image = nil
                        self.updateImage(with: posterURLL, posterImageView: posterImageView)
                    }
                }
                posterURLL = URL(string: item.poster.url)
            }
            return cell
        })
        
        dataSource.supplementaryViewProvider = { (collectionView, kind, indexPath) in
            guard let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: MovieListSectionHeaderView.identifier, for: indexPath) as? MovieListSectionHeaderView else {
                fatalError("Can't find HeaderView")
            }
            return headerView
        }
    }
}

// MARK: - Configure Layout

private extension MovieListView {
    func createLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { sectionIndex, layoutEnvironment in
            let itemSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .fractionalHeight(1.0)
            )
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            item.contentInsets = .init(
                top: 0,
                leading: 5,
                bottom: 0,
                trailing: 2.5
            )
            
            let innerGroupSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(0.5),
                heightDimension: .fractionalHeight(1.0)
            )
            let innerGroup = NSCollectionLayoutGroup.vertical(
                layoutSize: innerGroupSize,
                repeatingSubitem: item,
                count: 1
            )
            
            let nestedGroupSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(0.90),
                heightDimension: .fractionalHeight(0.25)
            )
            let nestedGroup = NSCollectionLayoutGroup.horizontal(
                layoutSize: nestedGroupSize,
                subitems: [innerGroup]
            )
    
            let headerSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .absolute(44)
            )
            let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
                layoutSize: headerSize,
                elementKind: UICollectionView.elementKindSectionHeader,
                alignment: .top
            )
            
            let section = NSCollectionLayoutSection(group: nestedGroup)
            section.boundarySupplementaryItems = [sectionHeader]
            section.orthogonalScrollingBehavior = .groupPagingCentered
            return section
        }
        return layout
    }
}
