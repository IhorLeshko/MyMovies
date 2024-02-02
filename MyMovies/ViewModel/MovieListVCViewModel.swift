//
//  MovieListVCViewModel.swift
//  MyMovies
//
//  Created by Ihor on 01.02.2024.
//

import Foundation
import UIKit

class MovieListVCViewModel {
    private let coreService = CoreManager.shared
    private let movieService = MMMovieService()
    
    var onMoviesUpdated: (()->Void)?
    var onErrorMessage: ((String)->Void)?
    
    private(set) var alertErrorMessage: String? = "" {
        didSet {
            self.onErrorMessage?(alertErrorMessage ?? "")
        }
    }
    
    private(set) var moviesList: [MMMovieResult] = [] {
        didSet {
            self.onMoviesUpdated?()
        }
    }
    
    private(set) var moviesGenres: [MMGenre] = []
    
    
    init() {
        getMovies()
        getGenres()
    }
    
    func findGenresFromIDs(moviesGenreIDs: [Int], allMoviesGenres: [MMGenre]) -> String {
        var genresIDsToName: [String] = []
        
        for id in moviesGenreIDs {
            allMoviesGenres.forEach { genre in
                if genre.id == id {
                    genresIDsToName.append(genre.name)
                }
            }
        }
        return genresIDsToName.joined(separator: ", ")
    }
    
    func getMovies() {
        movieService.downloadData(dataType: .topRatedMovies) { data, error in
            guard let data = data, error == nil else {
                DispatchQueue.main.async { [weak self] in
                    self?.alertErrorMessage = error
                }
                return
            }
            
            guard let movies = try? JSONDecoder().decode(MMMovie.self, from: data) else { return }
            
            DispatchQueue.main.async { [weak self] in
                self?.moviesList = movies.results
            }
                
        }
    }
    
    func getGenres() {
        movieService.downloadData(dataType: .movieGenres) { data, error in
            guard let data = data, error == nil else {
                self.alertErrorMessage = error
                return
            }
            
            guard let genres = try? JSONDecoder().decode(MMMovieGenres.self, from: data) else { return }
            
            DispatchQueue.main.async { [weak self] in
                self?.moviesGenres = genres.genres
            }
        }
    }
    
    func addNewFavouriteMovie(title: String, year: String, genre: String, image: Data) {
        coreService.addNewFavouriteMovie(title: title, year: year, genre: genre, image: image)
    }
}
