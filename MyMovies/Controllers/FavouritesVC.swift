//
//  FavouritesVC.swift
//  MyMovies
//
//  Created by Ihor on 31.01.2024.
//

import UIKit

class FavouritesVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        configureVC()
        configureInfoButton()
    }
    
    private func configureVC() {
        view.backgroundColor = .systemBackground
    }
    
    private func configureInfoButton() {
        let info = UIAction(title: "You can long tap on movie to delete it from Favourites", handler: {action in })
        let infoButton : UIMenu = UIMenu(title: "", children: [info])
        let rightBarButton = UIBarButtonItem(title: "", image: UIImage(systemName: "info.circle"), menu: infoButton)
        
        navigationItem.rightBarButtonItem = rightBarButton
        
    }

}
