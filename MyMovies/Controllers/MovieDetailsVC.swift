//
//  MovieDetailsVC.swift
//  MyMovies
//
//  Created by Ihor on 31.01.2024.
//

import UIKit

class MovieDetailsVC: UIViewController {
    
    var movieTitle: String?

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        self.navigationItem.title = movieTitle
    }
}
