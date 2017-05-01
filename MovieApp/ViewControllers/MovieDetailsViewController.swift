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
        
//        let tapGestureRecognizer: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTapGestureRecognizer(_:)))
//        tapGestureRecognizer.numberOfTapsRequired = 1
//        self.player.view.addGestureRecognizer(tapGestureRecognizer)
    }
    
    //    func handleTapGestureRecognizer(_ gestureRecognizer: UITapGestureRecognizer) {
    //        switch (self.player.playbackState.rawValue) {
    //        case PlaybackState.stopped.rawValue:
    //            self.player.playFromBeginning()
    //        case PlaybackState.paused.rawValue:
    //            self.player.playFromCurrentTime()
    //        case PlaybackState.playing.rawValue:
    //            self.player.pause()
    //        case PlaybackState.failed.rawValue:
    //            self.player.pause()
    //        default:
    //            self.player.pause()
    //        }
    //    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if let videoURL = movie.videoUrl{
            let player = AVPlayer(url: URL(string:videoURL)!)
            let playerLayer = AVPlayerLayer(player: player)
            let dateTextViewFrame = dateTextView.frame
            
            playerLayer.frame = CGRect(x: dateTextViewFrame.origin.x,
                                       y: dateTextViewFrame.origin.y ,
                                       width: UIScreen.main.bounds.width - 50,
                                       height: 300)
            self.view.layer.addSublayer(playerLayer)
            
            player.play()
        }
    }
    
    // "View in iTunes" button clicked, launch browser to view movie from iTunes
    @IBAction func onClick(_ sender: UIButton) {
        var itunesLink = movie.link
        // Remove https header from movie link
        let index = itunesLink.index(itunesLink.startIndex, offsetBy: 5)
        itunesLink = itunesLink.substring(from: index)
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(URL(string: "itms\(itunesLink)")!)
        } else {
            UIApplication.shared.openURL(URL(string: "itms\(itunesLink)")!)
        }
    }

}
