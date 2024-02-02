//
//  MMMovieGenres.swift
//  MyMovies
//
//  Created by Ihor on 01.02.2024.
//

import Foundation

struct MMMovieGenres: Codable {
    let genres: [MMGenre]
}

struct MMGenre: Codable {
    let id: Int
    let name: String
}
