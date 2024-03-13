//
//  Definitions.swift
//  stori-ios-challenge
//
//  Created by Daniel Tibaquira on 11/03/24.
//

import Foundation

struct Definitions {
    // TableView
    static let cellIdentifier = "MoviesTableViewCell"
    static let cellAccesibilityPrefix = "MoviesTableViewCell-"
    static let cellDefaultIdentifier = "DefaultCell"
    static let numberOfRowsInSection = 0
    static let cellHeight: CGFloat = 165
    
    // UIView
    static let moviesViewControllerFileName = "MoviesViewController"
    static let callAlreadyRunningAlertMessage = "A call is already running, please wait a couple seconds."
    
    // Services
    static let authorizationHeader = "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJjMGQzYTkyMTc3ZTIzMmM4YzU3MTM0M2M4MjBkYTQ1MiIsInN1YiI6IjYyNDQ3NjM0NWE5OTE1MDA0ODQ5Njc2YiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.S69NU5tdGM7faxVcMxEQ8oVRivM1M-RNrOjYKCzac-8"
    static let imagesEndpoint = "https://image.tmdb.org/t/p/w500"
    static func topRatedMovies(atPage: Int) -> String {
       return "https://api.themoviedb.org/3/discover/movie?&page=\(atPage)&sort_by=vote_average.desc&vote_count.gte=200"
    }
}
