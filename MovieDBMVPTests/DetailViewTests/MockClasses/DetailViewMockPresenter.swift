//
//  DetailViewMockPresenter.swift
//  MovieDBMVPTests
//
//  Created by Abdullah Onur Şimşek on 23.01.2024.
//

import Foundation
@testable import MovieDBMVP

final class DetailViewMockPresenter: DetailViewPresentationLogic {
    var inputs: [Bool] = .init()
    
    func fetchMovieDetail() {
        inputs.append(true)
    }
    
}
