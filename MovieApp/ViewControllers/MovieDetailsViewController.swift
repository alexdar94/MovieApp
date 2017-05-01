//
//  MovieDetailsViewController.swift
//  MovieApp
//
//  Created by Alex Lee on 30/04/2017.
//  Copyright © 2017 alex. All rights reserved.
//

import UIKit
import AVFoundation
import AVKit

class MovieDetailsViewController: UIViewController {
    var movie: Movie!
    
    @IBOutlet weak var titleTextView: UITextView!
    @IBOutlet weak var priceTextView: UITextView!
    @IBOutlet weak var dateTextView: UITextView!
    @IBOutlet weak var posterImageView: UIImageView!
    
    var isRandom = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // If it's random, display message
        if isRandom {self.view.makeToast("I'm feeling lucky!", duration:2.0, position: .center)}
        
        titleTextView.text = movie.title;
        priceTextView.text = movie.price;
        dateTextView.text = movie.date;
        
        // If there is HD poster, use HD poster
        // Else use low resolution poster
        let posterURL = movie.posterHDUrl ?? movie.posterUrl
        posterImageView.af_setImage(
            withURL: URL(string: posterURL)!
            , placeholderImage: UIImage(named: "movie")!)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        // Play trailer if trailer url existed
        if let videoURL = movie.videoUrl{
            let player = AVPlayer(url: URL(string:videoURL)!)
            let playerLayer = AVPlayerLayer(player: player)
            let dateTextViewFrame = dateTextView.frame
            playerLayer.frame = CGRect(x: dateTextViewFrame.origin.x,
                                       y: dateTextViewFrame.origin.y + 10,
                                       width: UIScreen.main.bounds.width - 50,
                                       height: 300)
            self.view.layer.addSublayer(playerLayer)
            
            player.play()
        }
    }
    
    // "View on iTunes" button clicked, launch browser to view movie in iTunes App
    @IBAction func onClick(_ sender: UIButton) {
        var itunesLink = movie.link
        // Remove https header from movie link
        // Then add itms header
        let index = itunesLink.index(itunesLink.startIndex, offsetBy: 5)
        itunesLink = "itms\(itunesLink.substring(from: index))"
        print(itunesLink)
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(URL(string: itunesLink)!)
        } else {
            UIApplication.shared.openURL(URL(string: itunesLink)!)
        }
    }

}
