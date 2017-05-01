//
//  TopMoviesTableViewCell.swift
//  MovieApp
//
//  Created by Alex Lee on 30/04/2017.
//  Copyright © 2017 alex. All rights reserved.
//

import UIKit
import AlamofireImage
import ChameleonFramework

class TopMoviesTableViewCell: UITableViewCell {

    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var dateTextView: UITextView!
    @IBOutlet weak var titleTextView: UITextView!
    @IBOutlet weak var priceTextView: UITextView!
    @IBOutlet weak var shadowView: UIView!
    @IBOutlet weak var gradientTextBackgroundView: UIView!
    
    var movie: Movie?{
        didSet {
            titleTextView.text = movie?.title
            dateTextView.text = movie?.date
            priceTextView.text = movie?.price
            
            if let posterUrl = movie?.posterHDUrl! {
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
        posterImageView.layer.masksToBounds = true
        posterImageView.layer.cornerRadius = 5
        gradientTextBackgroundView.layer.masksToBounds = true
        let mask = CAGradientLayer()
        //mask.frame = gradientTextBackgroundView.bounds
        mask.frame = CGRect(origin: CGPoint(x: 0, y: 0),
                            size: UIScreen.main.bounds.size)
        mask.startPoint = CGPoint(x: 0, y: 0)
        mask.endPoint = CGPoint(x: 1, y: 1)
        let color = UIColor.black
        mask.colors = [color.withAlphaComponent(0.0).cgColor,color.withAlphaComponent(1.0)]
        mask.locations = [NSNumber(value: 0.0),NSNumber(value: 1.0)]
        gradientTextBackgroundView.layer.mask = mask
    }
    
    
}
