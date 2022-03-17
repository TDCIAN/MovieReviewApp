//
//  MovieListPresenter.swift
//  MovieReviewApp
//
//  Created by JeongminKim on 2022/03/17.
//

import UIKit

protocol MovieListProtocol: AnyObject {
    func setupNavigationBar()
    func setupSearchBar()
    func setupViews()
    func updateSearchTableView(isHidden: Bool)
    func pushToMovieViewController(with movie: Movie)
}

final class MovieListPresenter: NSObject {
    private weak var viewController: MovieListProtocol?
    private let movieSearchManager: MovieSearchManagerProtocol
    
    private var likedMovie: [Movie] = [
        Movie(title: "Starwars", imageURL: "", userRating: "5.0", actor: "ABC", director: "ABC", pubDate: "2021"),
        Movie(title: "Starwars", imageURL: "", userRating: "5.0", actor: "ABC", director: "ABC", pubDate: "2021"),
        Movie(title: "Starwars", imageURL: "", userRating: "5.0", actor: "ABC", director: "ABC", pubDate: "2021")
    ]
    
    private var currentMovieSearchResult: [Movie] = []
    
    init(
        viewController: MovieListProtocol,
        movieSearchManager: MovieSearchManagerProtocol = MovieSearchManager()
    ) {
        self.viewController = viewController
        self.movieSearchManager = movieSearchManager
    }
    
    func viewDidLoad() {
        viewController?.setupNavigationBar()
        viewController?.setupSearchBar()
        viewController?.setupViews()
    }
}

extension MovieListPresenter: UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        viewController?.updateSearchTableView(isHidden: false)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        currentMovieSearchResult.removeAll()
        viewController?.updateSearchTableView(isHidden: true)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        movieSearchManager.request(from: searchText) { [weak self] movies in
            self?.currentMovieSearchResult = movies
            self?.viewController?.updateSearchTableView(isHidden: false)
        }
    }
}

extension MovieListPresenter: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        let spacing: CGFloat = 16.0
        let width: CGFloat = (collectionView.frame.width - spacing * 3) / 2
        return CGSize(width: width, height: 210)
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        insetForSectionAt section: Int
    ) -> UIEdgeInsets {
        let inset: CGFloat = 16.0
        
        return UIEdgeInsets(top: inset, left: inset, bottom: inset, right: inset)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let movie = likedMovie[indexPath.item]
        viewController?.pushToMovieViewController(with: movie)
    }
}

extension MovieListPresenter: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return likedMovie.count
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: MovieListCollectionViewCell.identifier,
            for: indexPath) as? MovieListCollectionViewCell else {
            return UICollectionViewCell()
        }
        let movie = likedMovie[indexPath.row]
        cell.update(movie)
        return cell
    }
}

extension MovieListPresenter: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let movie = currentMovieSearchResult[indexPath.row]
        viewController?.pushToMovieViewController(with: movie)
    }
}

extension MovieListPresenter: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentMovieSearchResult.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let movie = currentMovieSearchResult[indexPath.row]
        cell.textLabel?.text = movie.title
        return cell
    }
}
