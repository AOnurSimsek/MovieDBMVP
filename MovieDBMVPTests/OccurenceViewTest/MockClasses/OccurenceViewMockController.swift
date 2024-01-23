//
//  OccurenceViewMockController.swift
//  MovieDBMVPTests
//
//  Created by Abdullah Onur Şimşek on 23.01.2024.
//

import Foundation
@testable import MovieDBMVP

final class OccurenceViewMockController: BaseViewController,
                                         OccurenceViewDisplayLogic {
    var loadingVisibilty: [Bool] = .init()
    var occurenceData: [OccurenceViewDisplayModel] = .init()

    func showLoading(isLoading: Bool) {
        loadingVisibilty.append(isLoading)
    }
    
    func display(_ displayData: OccurenceViewDisplayModel) {
        occurenceData.append(displayData)
    }
    
}
