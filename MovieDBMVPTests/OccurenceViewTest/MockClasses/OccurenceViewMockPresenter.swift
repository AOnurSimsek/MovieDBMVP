//
//  OccurenceViewMockPresenter.swift
//  MovieDBMVPTests
//
//  Created by Abdullah Onur Şimşek on 23.01.2024.
//

import Foundation
@testable import MovieDBMVP

final class OccurenceViewMockPresenter: OccurenceViewPresentationLogic {
    var inputs: [Bool] = .init()
    
    func calculateOccurence() {
        inputs.append(true)
    }
    
}
