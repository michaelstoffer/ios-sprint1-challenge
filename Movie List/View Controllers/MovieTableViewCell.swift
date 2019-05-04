//
//  MovieTableViewCell.swift
//  Movie List
//
//  Created by Michael Stoffer on 5/4/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

class MovieTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var seenButton: UIButton!
    
    var movie: Movie? {
        didSet {
            updateViews()
        }
    }
    
    weak var delegate: MovieTableViewCellDelegate?
    
    private func updateViews() {
        guard let movie = self.movie else { return }
        
        self.nameLabel.text = movie.name
        
        if movie.seen == true {
            self.seenButton.setTitle("Seen", for: .normal)
        } else {
            self.seenButton.setTitle("Not Seen", for: .normal)
        }
    }

    @IBAction func seenButtonTapped(_ sender: Any) {
        delegate?.tappedSeenButton(on: self)
    }
}
