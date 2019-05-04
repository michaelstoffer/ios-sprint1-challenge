//
//  MovieController.swift
//  Movie List
//
//  Created by Michael Stoffer on 5/4/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import Foundation

class MovieController {
    private (set) var movies: [Movie] = []
    
    func createMovie(with name: String, seen: Bool) {
        let movie = Movie(name: name, seen: seen)
        movies.append(movie)
    }
    
    func updateMovie(with movie: Movie, name: String) {
        guard let index = movies.firstIndex(of: movie) else { return }
        movies[index].name = name
    }
    
    func removeMovie(with movie: Movie) {
        guard let index = movies.firstIndex(of: movie) else { return }
        movies.remove(at: index)
    }
    
    func toggledSeen(at indexPath: IndexPath) {
        self.movies[indexPath.row].seen.toggle()
    }
}
