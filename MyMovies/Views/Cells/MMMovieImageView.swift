//
//  MMMovieImageView.swift
//  MyMovies
//
//  Created by Ihor on 31.01.2024.
//

import UIKit

class MMMovieImageView: UIImageView {

    let moviePlaceholder = UIImage(named: "MoviePlaceholder")
    
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
    
    func downloadImage(from urlString: String) {
        guard let url = URL(string: MMConstants.posterHttp + MMConstants.posterLowQualtySetPath + urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if error != nil { return }
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else { return }
            guard let data = data else { return }
            
            guard let image = UIImage(data: data) else { return }
            
            DispatchQueue.main.async { [weak self] in
                self?.image = image
            }
            
        }
        .resume()
    }
}
