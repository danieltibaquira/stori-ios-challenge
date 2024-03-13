//
//  MoviesPresenter.swift
//  stori-ios-challenge
//
//  Created by Daniel Tibaquira on 11/03/24.
//

import Foundation
import UIKit

protocol MoviesPresenterDelegate: AnyObject {
    func moviesDataFetched()
    func moviesDataFailedToLoad()
    func presentAlreadyRunningCallAlert()
    func scrollViewDidScroll(_ scrollView: UIScrollView)
    func displayDetailsFor(movie: Movie)
}

class MoviesPresenter: NSObject {
    var delegate: MoviesPresenterDelegate?
    var movies = [Movie]()
    let interactor: MoviesInteractor
    
    init(interactor: MoviesInteractor) {
        self.interactor = interactor
    }
    
    func performFetch() {
        interactor.fetchMoviesData()
    }
}

extension MoviesPresenter: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Definitions.cellIdentifier) as? MoviesTableViewCell,
              let movie = movies[safe: indexPath.row] else {
            return tableView.getDefaultCell(indexPath: indexPath)
        }
        
        cell.accessibilityIdentifier = "\(Definitions.cellAccesibilityPrefix)\(indexPath.row)"
        cell.selectionStyle = .none
        
        cell.configure(with: movie)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let movie = movies[safe: indexPath.row] {
            delegate?.displayDetailsFor(movie: movie)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(Definitions.cellHeight)
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let currentOffset = scrollView.contentOffset.y
        let maximumOffset = scrollView.contentSize.height - scrollView.frame.size.height

        // Change 10.0 to adjust the distance from bottom
        if maximumOffset - currentOffset <= 10.0 {
            delegate?.scrollViewDidScroll(scrollView)
            performFetch()
        }
    }
}

extension MoviesPresenter: MoviesInteractorDelegate {
    func moviesDataFetched(with data: [Movie]) {
        movies += data
        delegate?.moviesDataFetched()
    }
    
    func moviesDataFailed() {
        movies = [Movie]()
        delegate?.moviesDataFailedToLoad()
    }
    
    func callAlreadyRunning() {
        delegate?.presentAlreadyRunningCallAlert()
    }
}
