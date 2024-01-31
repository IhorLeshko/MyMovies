//
//  MovieListVC.swift
//  MyMovies
//
//  Created by Ihor on 31.01.2024.
//

import SwiftUI
import UIKit

class MovieListVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
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

