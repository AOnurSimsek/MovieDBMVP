//
//  DetailViewMockRouter.swift
//  MovieDBMVPTests
//
//  Created by Abdullah Onur Şimşek on 23.01.2024.
//

import Foundation
@testable import MovieDBMVP

final class DetailViewMockRouter: DetailViewRoutingLogic {
    var routeToAlert: Int = 0
    var routeToImdb:Int = 0
    
    func routeToIMDB(imdbId: String) {
        routeToImdb += 1
    }
    
    func routeToAlert(alertMessage: String) {
        routeToAlert += 1
    }
    
}

