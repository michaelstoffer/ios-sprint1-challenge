//
//  AddMovieViewController.swift
//  Movie List
//
//  Created by Michael Stoffer on 5/4/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

class AddMovieViewController: UIViewController {
    
    var movieController: MovieController?
    @IBOutlet weak var movieNameTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func addMovieButtonTapped(_ sender: Any) {
        guard let name = self.movieNameTextField.text else { return }
        
        if name != "" {
            self.movieController?.createMovie(with: name, seen: false)
            navigationController?.popViewController(animated: true)
        }
    }
}
