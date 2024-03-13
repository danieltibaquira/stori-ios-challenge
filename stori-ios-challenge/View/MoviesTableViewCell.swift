//
//  MoviesTableViewCell.swift
//  stori-ios-challenge
//
//  Created by Daniel Tibaquira on 12/03/24.
//

import UIKit

class MoviesTableViewCell: UITableViewCell {
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    
    func configure(with movie: Movie) {
        backgroundColor = .background
        
        titleLabel.text = movie.title
        titleLabel.font = UIFont.boldSystemFont(ofSize: 18)
        titleLabel.textColor = .labels
        titleLabel.lineBreakMode = .byTruncatingTail
        
        let roundedVoteAverage = round(movie.voteAverage * 10) / 10
        ratingLabel.text = "\(roundedVoteAverage)"
        ratingLabel.font = UIFont(name: "Poppins-Regular", size: 12)
        ratingLabel.textColor = .labels
        
        releaseDateLabel.text = movie.releaseDate
        releaseDateLabel.textColor = .labels
        releaseDateLabel.font = UIFont(name: "Poppins-Light", size: 14)
        
        if let data = movie.image, let image = UIImage(data: data) {
            posterImageView.image = image
        }
    }
}
