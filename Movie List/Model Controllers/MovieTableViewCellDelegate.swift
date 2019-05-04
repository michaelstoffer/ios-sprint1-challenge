//
//  MovieTableViewCellDelegate.swift
//  Movie List
//
//  Created by Michael Stoffer on 5/4/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import Foundation

protocol MovieTableViewCellDelegate: class {
    func tappedSeenButton(on cell: MovieTableViewCell)
}
