//
//  SwiftUIPreviewVC.swift
//  TestAPICall
//
//  Created by Ihor on 19.12.2023.
//

#if canImport(SwiftUI) && DEBUG
import SwiftUI
struct UIViewControllerPreview<MovieListVC: UIViewController>: UIViewControllerRepresentable {
    func updateUIViewController(_ uiViewController: MovieListVC, context: Context) {
        
    }
    
    let viewController: MovieListVC

    init(_ builder: @escaping () -> MovieListVC) {
        viewController = builder()
    }

    // MARK: - UIViewControllerRepresentable
    func makeUIViewController(context: Context) -> MovieListVC {
        viewController
    }
}
#endif
