//
//  MovieDetailsVC.swift
//  MyMovies
//
//  Created by Ihor on 31.01.2024.
//

import UIKit
import SwiftUI

class MovieDetailsVC: UIViewController {
    
    var movieImage: UIImageView = MMMovieImageView(frame: .zero)
    var movieLabel: UILabel = MMTitleLabel(textAlignment: .center, fontSize: 40)
    var movieDescription: UILabel = MMTitleLabel(textAlignment: .center, fontSize: 16)
    var movieYear: UILabel = MMTitleLabel(textAlignment: .center, fontSize: 20)
    
    
    private let scrollView: UIScrollView = UIScrollView()
    
    private let contentView: UIView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureVC()
        configureUI()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationController?.navigationBar.layoutIfNeeded()
        tabBarController?.tabBar.isHidden = true
        tabBarController?.tabBar.layoutIfNeeded()
    }
    
    private func configureVC() {
        view.backgroundColor = .systemBackground
    }
    
    private func configureUI() {
        configureScrollView()
        configureLabel()
        configureMovieImage()
        configureMovieDescription()
        configureYearText()
    }
    
    private func configureScrollView() {
        
        view.addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        scrollView.addSubview(contentView)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        let hConst = contentView.heightAnchor.constraint(equalTo: scrollView.heightAnchor)
        hConst.isActive = true
        hConst.priority = UILayoutPriority(50)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 10),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -10),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -20),
        ])
    }
    
    private func configureLabel() {
        view.addSubview(movieLabel)
        
        movieLabel.numberOfLines = 0
        
        NSLayoutConstraint.activate([
            movieLabel.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor),
            movieLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            movieLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            movieLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20)
        ])
    }
    
    
    private func configureMovieImage() {
        view.addSubview(movieImage)
        
        NSLayoutConstraint.activate([
            movieImage.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            movieImage.topAnchor.constraint(equalTo: movieLabel.bottomAnchor, constant: 40),
            movieImage.heightAnchor.constraint(equalToConstant: 330),
            movieImage.widthAnchor.constraint(equalToConstant: 250)
        ])
    }
    
    private func configureYearText() {
        view.addSubview(movieYear)
        
        NSLayoutConstraint.activate([
            movieYear.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            movieYear.topAnchor.constraint(equalTo: movieLabel.bottomAnchor, constant: 10),
        ])
    }
    
    private func configureMovieDescription() {
        view.addSubview(movieDescription)
        
        movieDescription.numberOfLines = 0
        
        NSLayoutConstraint.activate([
            movieDescription.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            movieDescription.topAnchor.constraint(equalTo: movieImage.bottomAnchor, constant: 20),
            movieDescription.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            movieDescription.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            movieDescription.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ])
    }
}

//Previews
class MovieDetailsVC_Preview: PreviewProvider {
    static var previews: some View {
        UIViewControllerPreview {
            let vc = MovieDetailsVC()
            return vc
        }
    }
}
