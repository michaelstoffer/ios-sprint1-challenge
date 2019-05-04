//
//  MovieViewController.swift
//  Movie List
//
//  Created by Michael Stoffer on 5/4/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

class MovieViewController: UIViewController {

    let movieController = MovieController()
    @IBOutlet weak var movieTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.movieTableView.delegate = self
        self.movieTableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.movieTableView.reloadData()
    }
    

    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ToAddMovie" {
            guard let addMovieViewController = segue.destination as? AddMovieViewController else { return }
            
            addMovieViewController.movieController = self.movieController
        } else if segue.identifier == "ToUpdateMovie" {
            guard let indexPath = movieTableView.indexPathForSelectedRow,
                let editMovieViewController = segue.destination as? EditMovieViewController else { return }
            
            let movie = self.movieController.movies[indexPath.row]
            
            editMovieViewController.movieController = self.movieController
            editMovieViewController.movie = movie
        }
    }

}

extension MovieViewController: UITableViewDelegate {
}

extension MovieViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.movieController.movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as? MovieTableViewCell else { return UITableViewCell() }
        
        let movie = movieController.movies[indexPath.row]
        cell.nameLabel.text = movie.name
        cell.delegate = self
        
        let seenText = movie.seen ? "Seen" : "Not Seen"
        cell.seenButton.setTitle(seenText, for: .normal)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let movie = self.movieController.movies[indexPath.row]
            self.movieController.removeMovie(with: movie)
            self.movieTableView.deleteRows(at: [indexPath], with: .none)
            self.movieTableView.reloadData()
        }
    }
}

extension MovieViewController: MovieTableViewCellDelegate {
    func tappedSeenButton(on cell: MovieTableViewCell) {
        guard let indexPath = movieTableView.indexPath(for: cell) else { return }
        
        self.movieController.toggledSeen(at: indexPath)
        self.movieTableView.reloadRows(at: [indexPath], with: .none)
    }
}
