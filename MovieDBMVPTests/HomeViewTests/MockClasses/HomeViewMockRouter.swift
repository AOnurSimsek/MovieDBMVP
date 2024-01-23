//
//  HomeViewMockRouter.swift
//  MovieDBMVPTests
//
//  Created by Abdullah Onur Şimşek on 23.01.2024.
//

import Foundation
@testable import MovieDBMVP

final class HomeViewMockRouter: HomeViewRoutingLogic {
    var routeToAlert: Int = 0
    var routeToOccurence:Int = 0
    var routeToDetail: Int = 0
    
    func routeToDetail(id: Int) {
        routeToDetail += 1
    }
    
    func routeToOccurence(title: String) {
        routeToOccurence += 1
    }
    
    func routeToAlert(alertMessage: String) {
        routeToAlert += 1
    }
    
}
