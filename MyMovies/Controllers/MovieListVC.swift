//
//  MovieListVC.swift
//  MyMovies
//
//  Created by Ihor on 31.01.2024.
//

import SwiftUI
import UIKit

class MovieListVC: UIViewController {
    
    var moviesList: [MMMovieResult] = []
    
    var collectionView: UICollectionView!
    var dataSource: UICollectionViewDataSource!
    var movieService = MMMovieService()
    
    var alertErrorMessage: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        configureVC()
        getMovies()
        configureCollectionView()
        collectionView.reloadData()
    }
    
    private func configureVC() {
        view.backgroundColor = .systemBackground
    }
    
    private func configureCollectionView() {
        collectionView = UICollectionView(frame: view.frame, collectionViewLayout: createThreeColumnFlowLayout())
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        view.addSubview(collectionView)
        
        collectionView.backgroundColor = .systemBackground
        collectionView.register(MMMovieCell.self, forCellWithReuseIdentifier: MMMovieCell.reuseID)
    }
    
    private func createThreeColumnFlowLayout() -> UICollectionViewFlowLayout {
        let width = view.bounds.width
        let padding: CGFloat = 12
        let minimumItemSpacing: CGFloat = 10
        let availableWidth = width - (padding * 2) - (minimumItemSpacing * 2)
        let itemWidth = availableWidth / 3
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.sectionInset = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        flowLayout.itemSize = CGSize(width: itemWidth, height: itemWidth + 80)
        
        return flowLayout
    }
    
    private func getMovies() {
        movieService.downloadData { data, error in
            guard let data = data, error == nil else {
                self.alertErrorMessage = error
                return
            }
            
            guard let movies = try? JSONDecoder().decode(MMMovie.self, from: data) else { return }
            
            DispatchQueue.main.async { [weak self] in
                self?.moviesList = movies.results
                self?.collectionView.reloadData()
            }
        }
    }

}

extension MovieListVC: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return moviesList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MMMovieCell.reuseID, for: indexPath) as! MMMovieCell
        cell.set(movie: moviesList[indexPath.item])
        return cell
    }
}

extension MovieListVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailVC = MovieDetailsVC()
        let selectedCell = collectionView.cellForItem(at: indexPath) as! MMMovieCell
        guard let selectedTitle = selectedCell.movieLabelView.text else { return }
        detailVC.movieTitle = selectedTitle
        navigationController?.pushViewController(detailVC, animated: true)
    }
}

//Previews
class MovieListVC_Preview: PreviewProvider {
    static var previews: some View {
        UIViewControllerPreview {
            let vc = MovieListVC()
            return vc
        }
    }
}

