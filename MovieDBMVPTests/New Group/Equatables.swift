//
//  Equatables.swift
//  MovieDBMVPTests
//
//  Created by Abdullah Onur Şimşek on 23.01.2024.
//

import Foundation
@testable import MovieDBMVP

// MARK: - APIError
extension APIError: Equatable {
    public static func == (lhs: APIError, rhs: APIError) -> Bool {
        return lhs.description == rhs.description
    }
    
}

// MARK: - Responses
extension MovieResultResponseModel: Equatable {
    public static func == (lhs: MovieResultResponseModel, rhs: MovieResultResponseModel) -> Bool {
        let id = lhs.id == rhs.id
        let title = lhs.title == rhs.title
        let voteAverage = lhs.voteAverage == rhs.voteAverage
        
        return id && title && voteAverage
    }
    
}

extension MovieDetailResponseModel: Equatable {
    public static func == (lhs: MovieDetailResponseModel, rhs: MovieDetailResponseModel) -> Bool {
        let id = lhs.id == rhs.id
        let title = lhs.title == rhs.title
        let imdbId = lhs.imdbId == rhs.imdbId
        
        return id && title && imdbId
    }
    
}

// MARK: - DisplayModels
extension DetailViewDisplayModel: Equatable {
    public static func == (lhs: DetailViewDisplayModel, rhs: DetailViewDisplayModel) -> Bool {
        return lhs.getAllData() == rhs.getAllData()
    }
    
}

extension OccurenceModel: Equatable {
    public static func == (lhs: OccurenceModel, rhs: OccurenceModel) -> Bool {
        let character = lhs.character == rhs.character
        let value = lhs.value == rhs.value
        return character && value
    }
    
}

extension OccurenceViewDisplayModel: Equatable {
    public static func == (lhs: OccurenceViewDisplayModel, rhs: OccurenceViewDisplayModel) -> Bool {
        let lhsData = lhs.getAllData()
        let rhsData = rhs.getAllData()
        
        let boolValue: [Bool] = lhsData.map { lhsInnerData in
            return rhsData.contains { $0 == lhsInnerData }
        }
        
        let hasFalse = boolValue.contains { $0 == false }
        
        return !hasFalse
    }
    
}

extension HomeViewDisplayModel: Equatable {
    public static func == (lhs: HomeViewDisplayModel, rhs: HomeViewDisplayModel) -> Bool {
        return lhs.getAllData() == rhs.getAllData()
    }
    
}

