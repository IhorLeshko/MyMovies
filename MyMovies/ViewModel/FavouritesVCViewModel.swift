//
//  FavouritesVCViewModel.swift
//  MyMovies
//
//  Created by Ihor on 01.02.2024.
//

import Foundation

class FavouritesVCViewModel {
    
    var movieService = MMMovieService()
    var coreService = CoreManager.shared
    
    private(set) var moviesGenres: [MMGenre] = []
    
}
