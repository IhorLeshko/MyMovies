//
//  CoreManager.swift
//  MyMovies
//
//  Created by Ihor on 01.02.2024.
//

import Foundation
import CoreData
import UIKit

class CoreManager {
    static let shared = CoreManager()
    
    var movies: [Movie] = [] {
        didSet {
            self.arrayUpdateCallback?(movies)
        }
    }
    
    var arrayUpdateCallback: (([Movie]) -> Void)?
    
    private init() {
        fetchFavouritesMovies()
    }
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "MyMovies")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func fetchFavouritesMovies() {
        let request = Movie.fetchRequest()
        if let movies = try? persistentContainer.viewContext.fetch(request) {
            self.movies = movies
        }
    }
    
    func addNewFavouriteMovie(title: String, year: String, genre: String, image: Data) {
        if !movies.contains(where: { $0.title == title }) {
            let movie = Movie(context: persistentContainer.viewContext)
            
            movie.id = UUID().uuidString
            movie.title = title
            movie.year = year
            movie.image = image
            movie.genre = genre
            
            saveContext()
            fetchFavouritesMovies()
        }
    }
    
    func deleteFavouriteMovie(movie: Movie) {
        persistentContainer.viewContext.delete(movie)
        try? persistentContainer.viewContext.save()
        fetchFavouritesMovies()
    }
    
    func updateMovies(_ newMovies: [Movie]) {
        movies = newMovies
    }
}
