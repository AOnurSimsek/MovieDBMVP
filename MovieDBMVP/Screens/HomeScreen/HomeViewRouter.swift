//
//  HomeViewRouter.swift
//  MovieDBMVP
//
//  Created by Abdullah Onur Şimşek on 23.01.2024.
//

import UIKit

protocol HomeViewRoutingLogic: AnyObject {
    func routeToDetail(id: Int)
    func routeToAlert(alertMessage: String)
    func routeToOccurence(title: String)
}

final class HomeViewRouter: HomeViewRoutingLogic {
    weak var controller: UIViewController?

    func routeToDetail(id: Int) {
        let vc = BaseBuilder.shared.createDetailScreen(movieId: String(id))
        controller?.navigationController?.pushViewController(vc, animated: true)
    }
    
    func routeToAlert(alertMessage: String) {
        let alertVC = UIAlertManager.shared.getSimpleAlertController(message: alertMessage)
        controller?.present(alertVC, animated: true)
    }
    
    func routeToOccurence(title: String) {
        let vc = BaseBuilder.shared.createOccurenceScreen(with: title)
        controller?.navigationController?.pushViewController(vc, animated: true)
    }
    
}
