//
//  DetailViewBuilder.swift
//  MovieDBMVP
//
//  Created by Abdullah Onur Şimşek on 31.01.2024.
//

import UIKit

final class DetailViewBuilder {
    func createDetailScreen(movieId: String) -> UIViewController {
        let movieWorker = MovieNetworkWorker()
        let router = DetailViewRouter()
        let presenter = DetailViewPresenter(movieWorker: movieWorker,
                                            movieId: movieId)
        let controller = DetailViewController(presenter: presenter,
                                              router: router)
        
        presenter.controller = controller
        router.controller = controller
        
        return controller
    }
    
}
