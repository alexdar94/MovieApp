//
//  Movie.swift
//  MovieApp
//
//  Created by Alex Lee on 30/04/2017.
//  Copyright © 2017 alex. All rights reserved.
//

import Foundation

class Movie {
    var title = ""
    var date = ""
    var price = ""
    var posterUrl = ""
    var posterHDUrl: String?
    var link = ""
    var videoUrl: String?
    
    init(title: String, date: String, price: String, posterUrl: String, posterHDUrl: String?, link: String, videoUrl: String?){
        self.title = title
        self.date = date
        self.price = price
        self.posterUrl = posterUrl
        self.posterHDUrl = posterHDUrl
        self.link = link
        self.videoUrl = videoUrl
    }
}
