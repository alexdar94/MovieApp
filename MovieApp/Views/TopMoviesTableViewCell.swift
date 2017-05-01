//
//  TopMoviesTableViewCell.swift
//  MovieApp
//
//  Created by Alex Lee on 30/04/2017.
//  Copyright © 2017 alex. All rights reserved.
//

import UIKit
import AlamofireImage

class TopMoviesTableViewCell: UITableViewCell {

    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var dateTextView: UITextView!
    @IBOutlet weak var titleTextView: UITextView!
    @IBOutlet weak var priceTextView: UITextView!
    @IBOutlet weak var shadowView: UIView!
    
    var movie: Movie?{
        didSet {
            titleTextView.text = movie?.title
            dateTextView.text = movie?.date
            priceTextView.text = movie?.price
            
            if let posterUrl = movie?.posterUrl {
                //print(posterUrl)
                posterImageView.af_setImage(
                    withURL: URL(string: posterUrl)!
                    , placeholderImage: UIImage(named: "movie")!)
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func layoutSubviews() {
        posterImageView.layer.masksToBounds = true;
        posterImageView.layer.cornerRadius = 5
    }
}
