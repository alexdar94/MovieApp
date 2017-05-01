//
//  ViewController.swift
//  MovieApp
//
//  Created by Alex Lee on 30/04/2017.
//  Copyright © 2017 alex. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import Floaty

class TopMoviesViewController: UIViewController {
    
    @IBOutlet weak var topMoviesTableView: UITableView!
    @IBOutlet weak var luckyFAB: Floaty!
    var topMovieAPI = "https://itunes.apple.com/us/rss/topmovies/limit=25/json"
    var topMovies: [Movie]! {
        didSet{
            topMoviesTableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        Alamofire.request(topMovieAPI).responseJSON { response in
            switch response.result {
            case .success:
                if let swiftyJSON = response.result.value {
                    let swiftyJsonVar = JSON(swiftyJSON)
                    let path: [JSONSubscriptType] = ["feed","entry"]
                    
                    if let moviesJSON = swiftyJsonVar[path].array {
                        for movieJSON in moviesJSON {
                            if let title = movieJSON[["im:name","label"]].string
                                ,let date = movieJSON[["im:releaseDate","attributes","label"]].string
                                ,let price = movieJSON[["im:price","label"]].string
                                ,let posterUrl = movieJSON[["im:image",0,"label"]].string
                                ,let link = movieJSON[["link",0,"attributes","href"]].string{
                                
                                let movie = Movie(title: title, date: date, price: price, posterUrl: posterUrl, posterHDUrl: movieJSON[["im:image",2,"label"]].string, link: link, videoUrl: movieJSON[["link",1,"attributes","href"]].string)
                                if (self.topMovies?.append(movie)) == nil {
                                    self.topMovies = [movie]
                                }
                            }
                        }
                    }
                }
            case .failure(let error):
                print(error)
            }
        }
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.onFABClicked(_:)))
        luckyFAB.addGestureRecognizer(tapGesture)
    }

    func onFABClicked(_ sender: UITapGestureRecognizer) {
        performSegue(withIdentifier: "toDetailsVC", sender: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier {
            if identifier == "toDetailsVC" {
                let movieDetailsViewController = segue.destination as! MovieDetailsViewController
                // If segue from table view cell
                if let index = topMoviesTableView.indexPathForSelectedRow{
                    movieDetailsViewController.movie = topMovies[index.row]
                }
                // If segue from FAB, randomly select movie
                else {
                    let randomInt = Int(arc4random_uniform(25))
                    movieDetailsViewController.movie = topMovies[randomInt]
                }
            }
        }
    }
    
    @IBAction func unwindToTopMoviesViewController(segue: UIStoryboardSegue) {
        
    }
}

// MARK: TableView Methods
extension TopMoviesViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.topMovies?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let view = cell.contentView
        view.layer.opacity = 0.1
        UIView.animate(withDuration: 1.4) {
            view.layer.opacity = 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "topMoviesTableViewCell", for: indexPath as IndexPath) as! TopMoviesTableViewCell
        
        cell.movie = topMovies[indexPath.row]

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        tableView.deselectRow(at: indexPath as IndexPath, animated: true)
    }
}

