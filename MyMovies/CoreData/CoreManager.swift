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
    var movies: [Movie] = []
    
    private init() {
        
        fetchFavouritesMovies()
    }
    
    lazy var persistentContainer: NSPersistentContainer = {
        ValueTransformer.setValueTransformer(ImageTransformer(), forName: NSValueTransformerName("ImageTransformer"))
        
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
    
    func addNewFavouriteMovie(title: String, year: String, genre: String, image: UIImage) {
        let movie = Movie(context: persistentContainer.viewContext)
        movie.id = UUID().uuidString
        movie.title = title
        movie.year = year
        movie.genre = genre
        movie.image = image
        
        saveContext()
        fetchFavouritesMovies()
    }
    
    func deleteFavouriteMovie(movie: Movie) {
        persistentContainer.viewContext.delete(movie)
        try? persistentContainer.viewContext.save()
        fetchFavouritesMovies()
    }
}
