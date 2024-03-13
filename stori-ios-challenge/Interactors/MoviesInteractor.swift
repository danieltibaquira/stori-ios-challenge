//
//  MoviesInteractor.swift
//  stori-ios-challenge
//
//  Created by Daniel Tibaquira on 11/03/24.
//

import Foundation

protocol MoviesInteractorDelegate: AnyObject {
    func moviesDataFetched(with data: [Movie])
    func moviesDataFailed()
    func callAlreadyRunning()
}

class MoviesInteractor {
    var currentPage = 0
    var currentlyFetching = false
    var delegate: MoviesInteractorDelegate?
    
    func fetchMoviesData() {
        if !currentlyFetching {
            currentPage += 1
            currentlyFetching = true
            MoviesRemoteService.getTopRatedMovies(atPage: currentPage) { result in
                self.currentlyFetching = false
                switch result {
                case .success(var movies):
                    print("Fetching of Top Rated Movies Succeeded")
                    
                    let group = DispatchGroup()
                    
                    for i in 0..<movies.count {
                        if let posterPath = movies[i].posterPath {
                            group.enter()
                            MoviesRemoteService.fetchPosterImage(with: posterPath) { result in
                                switch result {
                                case .success(let data):
                                    movies[i].image = data
                                case .failure(let error):
                                    print("Could not download image with Error: \(error)")
                                }
                                group.leave()
                            }
                        }
                    }
                    
                    group.notify(queue: .main) {
                        self.delegate?.moviesDataFetched(with: movies)
                    }
                case .failure(let error):
                    print("Fetching of Top Rated Movies failed with Error: \(error)")
                    self.delegate?.moviesDataFailed()
                }
            }
        } else {
            delegate?.callAlreadyRunning()
        }
    }
}
