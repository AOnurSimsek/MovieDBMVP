//
//  DetailViewMockController.swift
//  MovieDBMVPTests
//
//  Created by Abdullah Onur Şimşek on 23.01.2024.
//

import Foundation
@testable import MovieDBMVP

final class DetailViewMockController: BaseViewController,
                                              DetailViewDisplayLogic {
    var loadingVisibilty: [Bool] = .init()
    var movieDetails: [DetailViewDisplayModel] = .init()
    var alerts: [APIError] = .init()

    func showLoading(isLoading: Bool) {
        loadingVisibilty.append(isLoading)
    }
    
    func display(_ displayData: DetailViewDisplayModel) {
        movieDetails.append(displayData)
    }
    
    func display(_ displayData: APIError) {
        alerts.append(displayData)
    }
    
}
