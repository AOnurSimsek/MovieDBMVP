//
//  HomeViewMockController.swift
//  MovieDBMVPTests
//
//  Created by Abdullah Onur Şimşek on 23.01.2024.
//

import Foundation
@testable import MovieDBMVP

final class HomeViewMockController: BaseViewController,
                                    HomeViewDisplayLogic {
    var loadingVisibilty: [Bool] = .init()
    var movieDisplayModel: [HomeViewDisplayModel] = .init()
    var alerts: [APIError] = .init()
    
    func showLoading(isLoading: Bool) {
        loadingVisibilty.append(isLoading)
    }
    
    func display(_ displayData: HomeViewDisplayModel) {
        movieDisplayModel.append(displayData)
    }
    
    func display(_ displayData: [MovieResultResponseModel]) {
        var lastElement = movieDisplayModel.last
        lastElement?.addMoreData(data: displayData)
        
        if let data = lastElement {
            movieDisplayModel.append(data)
        }
        
    }
    
    func display(_ displayData: APIError) {
        alerts.append(displayData)
    }
    
}
