//
//  BaseBuilder.swift
//  MovieDBMVP
//
//  Created by Abdullah Onur Şimşek on 20.01.2024.
//

import UIKit

final class BaseBuilder {
    static let shared = BaseBuilder()
    
    func createSplashScreen() -> UIViewController {
        let controller: SplashViewController = .init()
        return controller
    }
    
    func createHomeScreen() -> UIViewController {
        let movieWorker = MovieNetworkWorker()
        let searchWorker = SearchNetworkWorker()
        let router = HomeViewRouter()
        let presenter = HomeViewPresenter(movieWorker: movieWorker,
                                          searchWorker: searchWorker)
        let controller = HomeViewController(presenter: presenter,
                                            router: router)
        
        presenter.controller = controller
        router.controller = controller
        
        let navController = UINavigationController(rootViewController: controller)
        
        return navController
    }
    
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
    
    func createOccurenceScreen(with title: String) -> UIViewController {
        let presenter = OccurenceViewPresenter(title: title)
        let controller = OccurenceViewController(presenter: presenter)
        
        presenter.controller = controller
        
        return controller
    }
    
}

