//
//  HomeViewBuilder.swift
//  MovieDBMVP
//
//  Created by Abdullah Onur Şimşek on 31.01.2024.
//

import UIKit

final class HomeViewBuilder {
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
    
}
