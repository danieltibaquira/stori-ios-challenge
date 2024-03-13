//
//  MovieDetailViewController.swift
//  stori-ios-challenge
//
//  Created by Daniel Tibaquira on 12/03/24.
//

import UIKit

class MovieDetailViewController: UIViewController {
    
    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    
    var movie: Movie?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let presentationController = presentationController as? UISheetPresentationController {
            presentationController.detents = [
                .medium(),
                .large()
            ]
            presentationController.prefersGrabberVisible = true
        }
        
        if let data = movie?.image, let image = UIImage(data: data) {
            posterImage.image = image
        }
        
        let voteAverage = movie?.voteAverage ?? 0
        let roundedVoteAverage = round(voteAverage * 10) / 10
        ratingLabel.text = "\(roundedVoteAverage)"
        ratingLabel.font = UIFont(name: "Poppins-Regular", size: 12)
        ratingLabel.textColor = .labels
        
        titleLabel.text = "\(movie?.title ?? "")"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 18)
        titleLabel.textColor = .labels
        titleLabel.lineBreakMode = .byTruncatingTail
        
        overviewLabel.text = "\(movie?.overview ?? "")"
        
        releaseDateLabel.text = "\(movie?.releaseDate ?? "")"
        releaseDateLabel.font = UIFont(name: "Poppins-Light", size: 14)
    }
}
