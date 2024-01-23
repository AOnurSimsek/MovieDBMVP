//
//  MockSearchWorker.swift
//  MovieDBMVPTests
//
//  Created by Abdullah Onur Şimşek on 23.01.2024.
//

import XCTest
@testable import MovieDBMVP

final class MockSearchWorker: SearchWorker {
    func searchMovie(page: Int, 
                     searchText: String,
                     completion: @escaping (Result<MoviesResponseModel, APIError>) -> Void) {
        if page == 1 {
            guard let movieData = Reader.read("SearchResponseModel", type: MoviesResponseModel.self)
            else {
                XCTFail("SearchResponseModel can not decoded")
                return
            }
            
            let data:Result<MoviesResponseModel,APIError> = .success(movieData)
            completion(data)
            
        } else if page == 2 {
            guard let movieData = Reader.read("SearchSecondPageResponseModel", type: MoviesResponseModel.self)
            else {
                XCTFail("SearchSecondPageResponseModel can not decoded")
                return
            }
            
            let data:Result<MoviesResponseModel,APIError> = .success(movieData)
            completion(data)
        }
        
    }
    
}
