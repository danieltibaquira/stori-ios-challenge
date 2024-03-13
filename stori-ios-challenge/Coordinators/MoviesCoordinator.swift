//
//  MoviesCoordinator.swift
//  stori-ios-challenge
//
//  Created by Daniel Tibaquira on 11/03/24.
//

import Foundation
import UIKit

class MoviesCoordinator {

    let viewController: MoviesViewController
    let navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        
        let interactor = MoviesInteractor()
        let presenter = MoviesPresenter(interactor: interactor)
        interactor.delegate = presenter

        viewController = MoviesViewController()
        viewController.presenter = presenter
        presenter.delegate = viewController
   }

    func start() {
        navigationController.pushViewController(viewController, animated: true)
    }

}
