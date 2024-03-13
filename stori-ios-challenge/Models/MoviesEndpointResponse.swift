//
//  MoviesEndpointResponse.swift
//  stori-ios-challenge
//
//  Created by Daniel Tibaquira on 12/03/24.
//

import Foundation

struct MoviesEndpointResponse: Decodable {
    let results: [Movie]
}
