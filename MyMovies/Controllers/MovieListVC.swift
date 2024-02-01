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
    var coreService = CoreManager.shared
    
    var alertErrorMessage: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        configureVC()
        getMovies()
        configureCollectionView()
        configureInfoButton()
        collectionView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = true
        tabBarController?.tabBar.isHidden = false
    }
    
    private func configureVC() {
        view.backgroundColor = .systemBackground
    }
    
    private func configureInfoButton() {
        let info = UIAction(title: "You can long tap on movie to save it to Favourites", handler: {action in })
        let infoButton : UIMenu = UIMenu(title: "", children: [info])
        let rightBarButton = UIBarButtonItem(title: "", image: UIImage(systemName: "info.circle"), menu: infoButton)
        
        navigationItem.rightBarButtonItem = rightBarButton
        
    }
    
    private func configureCollectionView() {
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress(_:)))
        collectionView = UICollectionView(frame: view.frame, collectionViewLayout: createThreeColumnFlowLayout())
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.addGestureRecognizer(longPressGesture)

        view.addSubview(collectionView)
        
        collectionView.backgroundColor = .systemBackground
        collectionView.register(MMMovieCell.self, forCellWithReuseIdentifier: MMMovieCell.reuseID)
    }
    
    @objc private func handleLongPress(_ gestureRecognizer: UILongPressGestureRecognizer) {
        
            if gestureRecognizer.state == .began {

                let point = gestureRecognizer.location(in: collectionView)
                if let indexPath = collectionView.indexPathForItem(at: point) {
                    let selectedCell = collectionView.cellForItem(at: indexPath) as! MMMovieCell
                    
                    let alert = UIAlertController(title: "Save \(selectedCell.movieLabelView.text ?? "") to favourites?", message: "", preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { action in
                        self.coreService.addNewFavouriteMovie(title: selectedCell.movieLabelView.text!, year: selectedCell.movieYear.text!, genre: selectedCell.movieGenre.text ?? "", image: selectedCell.movieImageView.image ?? UIImage())
                    }))
                    alert.addAction(UIAlertAction(title: "No", style: .cancel))
                    
                    self.present(alert, animated: true, completion: nil)
                    
                    print("Long press on item at section \(indexPath.section) and item \(indexPath.item)")

                }
            }
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
        
        detailVC.movieLabel.text = selectedCell.movieLabelView.text
        detailVC.movieImage.image = selectedCell.movieImageView.image
        detailVC.movieYear.text = selectedCell.movieYear.text
        detailVC.movieDescription.text = selectedCell.movieDecription.text
        
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

