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
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func onClick(_ sender: UIButton) {
        UIApplication.shared.open(URL(string: movie.link)!)
    }

}
