//
//  MoviesRemoteService.swift
//  stori-ios-challenge
//
//  Created by Daniel Tibaquira on 11/03/24.
//

import Foundation
import UIKit

typealias MoviesRemoteServiceCompletionReturnValue = (Result<[Movie], MoviesRemoteServiceError>) -> ()

final class MoviesRemoteService {
    static func getTopRatedMovies(atPage: Int, completion: @escaping MoviesRemoteServiceCompletionReturnValue) {
        let endpoint = Definitions.topRatedMovies(atPage: atPage)
        
        guard let url = URL(string: endpoint) else {
            completion(.failure(.invalidUrl))
            return
        }

        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = [
            "accept": "application/json",
            "Authorization": Definitions.authorizationHeader
        ]
       
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            
            guard let data = data, let response = response as? HTTPURLResponse else {
                completion(.failure(.invalidResponse))
                return
            }
            
            if error != nil {
                switch response.statusCode {
                case 400...499:
                    completion(.failure(.unathorizedCall))
                case 500...599:
                    completion(.failure(.serverError))
                default:
                    break
                }
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let moviesData = try decoder.decode(MoviesEndpointResponse.self, from: data)
                completion(.success(moviesData.results))
            } catch {
                completion(.failure(.failureDecoding))
            }
        }
        
        task.resume()
    }
    
    static func fetchPosterImage(with path: String, completion: @escaping (Result<Data, Error>) -> Void) {
        let baseURL = Definitions.imagesEndpoint
        guard let imageURL = URL(string: baseURL + path) else {
            completion(.failure(MoviesRemoteServiceError.invalidUrl))
           return
        }

        let task = URLSession.shared.dataTask(with: imageURL) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
                return
            }

            if let data = data {
                completion(.success(data))
            }
        }

        task.resume()
    }
}

enum MoviesRemoteServiceError: Error {
    case invalidUrl, invalidResponse, failureDecoding, unathorizedCall, serverError
}
