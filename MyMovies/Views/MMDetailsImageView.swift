//
//  MMDetailsImageView.swift
//  MyMovies
//
//  Created by Ihor on 31.01.2024.
//

import UIKit

class MMDetailsImageView: UIImageView {
    
    var moviePlaceholder = UIImage(named: "MoviePlaceholder")

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        layer.cornerRadius = 10
        clipsToBounds = true
        image = moviePlaceholder
        translatesAutoresizingMaskIntoConstraints = false
    }
    

}
