//
//  EditMovieViewController.swift
//  Movie List
//
//  Created by Michael Stoffer on 5/4/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

class EditMovieViewController: UIViewController {
    
    var movieController: MovieController?
    @IBOutlet weak var movieNameTextField: UITextField!
    
    var movie: Movie? {
        didSet {
            updateViews()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.updateViews()
    }
    
    @IBAction func updateMovieButtonTapped(_ sender: Any) {
        guard let movie = self.movie,
            let name = self.movieNameTextField.text else { return }
        
        self.movieController?.updateMovie(with: movie, name: name)
        navigationController?.popViewController(animated: true)
    }
    
    private func updateViews() {
        guard let movie = self.movie, isViewLoaded else { return }
        
        self.movieNameTextField.text = movie.name
    }
}
