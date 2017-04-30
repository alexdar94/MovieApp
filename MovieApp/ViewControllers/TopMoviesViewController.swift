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

class TopMoviesViewController: UIViewController {
    
    @IBOutlet weak var topMoviesTableView: UITableView!
    var topMovies: [Movie]! {
        didSet{
            topMoviesTableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        Alamofire.request("https://itunes.apple.com/us/rss/topmovies/limit=25/json").responseJSON { response in
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
                                
                                let movie = Movie(title: title, date: date, price: price, posterUrl: posterUrl, posterHDUrl: movieJSON[["im:image",2,"label"]].string, link: link)
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
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier {
            if identifier == "toDetailsVC" {
                let movieDetailsViewController = segue.destination as! MovieDetailsViewController
                movieDetailsViewController.movie = topMovies[topMoviesTableView.indexPathForSelectedRow!.row]
            }
        }
    }
    
    @IBAction func unwindToTopMoviesViewController(segue: UIStoryboardSegue) {
        
    }
}

// MARK: TableView Methods
extension TopMoviesViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.topMovies?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "topMoviesTableViewCell", for: indexPath as IndexPath) as! TopMoviesTableViewCell
        
        cell.movie = topMovies[indexPath.row]
//        let formatter = NSDateFormatter()
//        formatter.dateFormat = "HH:mm"
//        cell.lastMessageTimeLabel.text = formatter.stringFromDate(chatRoom.lastMessageTime)

        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath as IndexPath, animated: true)
    }
}

