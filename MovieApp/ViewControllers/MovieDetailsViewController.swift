//
//  MovieDetailsViewController.swift
//  MovieApp
//
//  Created by Alex Lee on 30/04/2017.
//  Copyright © 2017 alex. All rights reserved.
//

import UIKit

class MovieDetailsViewController: UIViewController {
    var movie: Movie!
    
    @IBOutlet weak var titleTextView: UITextView!
    @IBOutlet weak var priceTextView: UITextView!
    @IBOutlet weak var dateTextView: UITextView!
    @IBOutlet weak var posterImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        titleTextView.text = movie.title;
        priceTextView.text = movie.price;
        dateTextView.text = movie.date;
        
        // If there is HD poster, use HD poster
        // Else use low resolution poster
        if let posterHDUrl = movie.posterHDUrl {
            posterImageView.af_setImage(
                withURL: URL(string: posterHDUrl)!
                , placeholderImage: UIImage(named: "movie")!)
        } else {
            posterImageView.af_setImage(
                withURL: URL(string: movie.posterUrl)!
                , placeholderImage: UIImage(named: "movie")!)
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // "View in iTunes" button clicked, launch browser to view movie from iTunes
    @IBAction func onClick(_ sender: UIButton) {
        UIApplication.shared.open(URL(string: "itms://itunes.apple.com/us/movie/la-la-land/id1179249419?uo=2")!)
    }

}
