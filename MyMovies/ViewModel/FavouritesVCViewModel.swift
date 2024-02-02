//
//  FavouritesVCViewModel.swift
//  MyMovies
//
//  Created by Ihor on 01.02.2024.
//

import Foundation

class FavouritesVCViewModel {
    private var coreService = CoreManager.shared
    var onMovieArrayUpdated: (()->Void)?
    
    var coreDataMovies: [Movie] = [] {
        didSet {
            self.onMovieArrayUpdated?()
        }
    }
    
    init() {
        coreService.arrayUpdateCallback = { [weak self] newMovies in
            self?.coreDataMovies = newMovies
        }
        coreDataMovies = coreService.movies
    }
    
    func deleteFavouriteMovie(movie: Movie) {
        coreService.deleteFavouriteMovie(movie: movie)
        updateCoreDataMovies()
    }
    
    func updateCoreDataMovies() {
        self.coreDataMovies = coreService.movies
    }
}
