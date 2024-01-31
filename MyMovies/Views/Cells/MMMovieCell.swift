//
//  MMMovieCell.swift
//  MyMovies
//
//  Created by Ihor on 31.01.2024.
//

import UIKit

class MMMovieCell: UICollectionViewCell {
    static let reuseID = "MovieCell"
    
    let movieImageView = MMMovieImageView(frame: .zero)
    let movieLabelView = MMTitleLabel(textAlignment: .center, fontSize: 16)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(movie: MMMovieResult) {
        movieLabelView.text = movie.title
        movieImageView.downloadImage(from: movie.posterPath ?? "")
    }
    
    private func configure() {
        addSubview(movieImageView)
        addSubview(movieLabelView)
        
        
        let padding: CGFloat = 8
        
        NSLayoutConstraint.activate([
            movieImageView.topAnchor.constraint(equalTo: topAnchor, constant: padding),
            movieImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            movieImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            movieImageView.heightAnchor.constraint(equalToConstant: 140),
            
            movieLabelView.topAnchor.constraint(equalTo: movieImageView.bottomAnchor, constant: 12),
            movieLabelView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            movieLabelView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            movieLabelView.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
}
