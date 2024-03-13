//
//  ViewController.swift
//  stori-ios-challenge
//
//  Created by Daniel Tibaquira on 8/03/24.
//

import UIKit

class MoviesViewController: UIViewController {
    
    // UI Elements
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var noDataLabel: UILabel!
    var loadingSpinner: UIActivityIndicatorView?
    
    // Logic
    var presenter: MoviesPresenter?
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        print("viewDidLoad was triggered")
        setupTableView()
        loadingSpinner?.stopAnimating()
        presenter?.performFetch()
    }
    
    // MARK: - UI Methods
    private func setupTableView() {
        tableView.register(UINib(nibName: Definitions.cellIdentifier, bundle: nil), forCellReuseIdentifier: Definitions.cellIdentifier)
        tableView.registerDefaultCell()
        tableView.delegate = presenter
        tableView.dataSource = presenter
        
        loadingSpinner = UIActivityIndicatorView(style: .large)
        loadingSpinner?.frame = CGRect(x: 0, y: 0, width: self.tableView.bounds.width, height: 44)
        loadingSpinner?.color = .background
        loadingSpinner?.backgroundColor = .storiAccent
        
        tableView.tableFooterView = self.loadingSpinner
    }
}

// MARK: - Delegates - MoviesPresenterDelegate
extension MoviesViewController: MoviesPresenterDelegate {
    func displayDetailsFor(movie: Movie) {
        let detailsVC = MovieDetailViewController()
        detailsVC.movie = movie
        present(detailsVC, animated: true, completion: nil)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        
        if offsetY > contentHeight - scrollView.frame.height {
            if !self.loadingSpinner!.isAnimating {
                self.loadingSpinner!.startAnimating()
            }
        }
    }
    
    func moviesDataFetched() {
        // Reload table view and remove spinner if needed
        DispatchQueue.main.async {
            if self.loadingSpinner?.isAnimating ?? false {
                self.loadingSpinner?.stopAnimating()
            }
            self.tableView.isHidden = false
            self.noDataLabel.isHidden = true
            self.tableView.reloadData()
        }
    }
    
    func moviesDataFailedToLoad() {
        DispatchQueue.main.async {
            // Remove all table view elements and display a meesage
            if self.loadingSpinner?.isAnimating ?? false {
                self.loadingSpinner?.stopAnimating()
            }
            self.tableView.reloadData()
            self.tableView.isHidden = true
            self.noDataLabel.isHidden = false
        }
    }
    
    func presentAlreadyRunningCallAlert() {
        DispatchQueue.main.async {
            // Present a toast saying that a call is already running
            if self.loadingSpinner?.isAnimating ?? false {
                self.loadingSpinner?.stopAnimating()
            }
            self.showToast(message: Definitions.callAlreadyRunningAlertMessage, seconds: 3.0)
        }
    }
}

// MARK: - Delegates - UIViewControllerTransitioningDelegate
extension MoviesViewController: UIViewControllerTransitioningDelegate { }
