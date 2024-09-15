//
//  MovieListView.swift
//  MoviesForLeisureApp
//
//  Created by Nikolai Maksimov on 11.09.2024.
//

import UIKit
import SnapKit

final class MovieListView: UIView {
    
    // MARK: - Private properties
    
    private typealias DataSource = UICollectionViewDiffableDataSource<SectionKind, Movie>
    private var dataSource: DataSource!
    
    private enum SectionKind: Int, CaseIterable {
        case movie
        case tvSeries
        case cartoon
        
        var engTitle: String {
            switch self {
            case .movie:
                return "movie"
            case .tvSeries:
                return "tv-series"
            case .cartoon:
                return "cartoon"
            }
        }
    }
    
    private lazy var movies: [Movie] = [] {
        didSet {
            var snapshot = dataSource.snapshot()
            movies.forEach { movie in
                if movie.type == "movie" {
                    snapshot.appendItems([movie], toSection: .movie)
                } else if movie.type == "tv-series" {
                    snapshot.appendItems([movie], toSection: .tvSeries)
                } else {
                    snapshot.appendItems([movie], toSection: .cartoon)
                }
            }
            dataSource.apply(snapshot, animatingDifferences: true)
        }
    }
    
    // MARK: - UI Components
    
    private var collectionView: UICollectionView!
    
    // MARK: - Life cycle
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Private methods

private extension MovieListView {
    func commonInit() {
        configureCollectionView()
        configureDataSource()
        setupSubviews()
        setupConstraints()
        fetchMovies()
    }
    
    func setupSubviews() {
        addSubview(collectionView)
    }
    
    func setupConstraints() {
        collectionView.snp.makeConstraints { make in
            make.horizontalEdges.verticalEdges.equalToSuperview()
        }
    }
    
    func fetchMovies() {
        Task {
            do {
                movies = try await NetworkManager.shared.fetchMovies().docs
            } catch NetworkError.invalidURL {
                print("invalidURL")
            } catch NetworkError.decodingError {
                print("decodingError")
            } catch {
                print("don't now what the problem")
            }
        }
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
            cell.configure(with: item)
            return cell
        })
        
        dataSource.supplementaryViewProvider = { (collectionView, kind, indexPath) in
            guard let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: MovieListSectionHeaderView.identifier, for: indexPath) as? MovieListSectionHeaderView else {
                fatalError("Can't find HeaderView")
            }
            return headerView
        }
        
        var snapshot = NSDiffableDataSourceSnapshot<SectionKind, Movie>()
        snapshot.appendSections([.movie, .tvSeries, .cartoon])
        dataSource.apply(snapshot, animatingDifferences: false)
    }
}

// MARK: - Configure Layout

private extension MovieListView {
    func configureCollectionView() {
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
        collectionView.register(MovieListCell.self, forCellWithReuseIdentifier: MovieListCell.identifier)
        collectionView.register(
            MovieListSectionHeaderView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: MovieListSectionHeaderView.identifier
        )
    }
    
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
