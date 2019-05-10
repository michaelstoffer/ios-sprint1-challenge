//
//  MovieController.swift
//  Movie List
//
//  Created by Michael Stoffer on 5/4/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import Foundation

class MovieController {
    
    init() {
        self.loadFromPersistentStore()
    }
    
    private (set) var movies: [Movie] = []
    
    private var persistentFileURL: URL? {
        let fileManager = FileManager.default
        guard let documentsDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
        
        return documentsDirectory.appendingPathComponent("movies.plist")
    }
    
    func createMovie(with name: String, seen: Bool) {
        let movie = Movie(name: name, seen: seen)
        movies.append(movie)
        self.saveToPersistentStore()
    }
    
    func updateMovie(with movie: Movie, name: String) {
        guard let index = movies.firstIndex(of: movie) else { return }
        movies[index].name = name
        self.saveToPersistentStore()
    }
    
    func removeMovie(with movie: Movie) {
        guard let index = movies.firstIndex(of: movie) else { return }
        movies.remove(at: index)
        self.saveToPersistentStore()
    }
    
    func toggledSeen(at indexPath: IndexPath) {
        self.movies[indexPath.row].seen.toggle()
        self.saveToPersistentStore()
    }
    
    // Saving
    func saveToPersistentStore() {
        guard let url = self.persistentFileURL else { return }
        
        do {
            let encoder = PropertyListEncoder()
            let data = try encoder.encode(self.movies)
            try data.write(to: url)
        } catch {
            NSLog("Error saving movies data: \(error)")
        }
    }
    
    // Loading
    func loadFromPersistentStore() {
        let fileManager = FileManager.default
        guard let url = self.persistentFileURL,
            fileManager.fileExists(atPath: url.path) else { return }
        
        do {
            let data = try Data(contentsOf: url)
            let decoder = PropertyListDecoder()
            self.movies = try decoder.decode([Movie].self, from: data)
        } catch {
            NSLog("Error loading movies data: \(error)")
        }
    }
}
