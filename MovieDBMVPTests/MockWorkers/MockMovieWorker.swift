//
//  MockMovieWorker.swift
//  MovieDBMVPTests
//
//  Created by Abdullah Onur Şimşek on 23.01.2024.
//

import XCTest
@testable import MovieDBMVP

final class MockMovieWorker: MovieWorker {
    func getTopRatedMoview(with page: Int,
                           completion: @escaping (Result<MoviesResponseModel, APIError>) -> Void) {
        if page == 1 {
            guard let movieData = Reader.read("TopRatedResponseModel", type: MoviesResponseModel.self)
            else {
                XCTFail("TopRatedResponseModel can not decoded")
                return
            }
            
            let data:Result<MoviesResponseModel,APIError> = .success(movieData)
            completion(data)
            
        } else if page == 2 {
            guard let movieData = Reader.read("TopRatedSecondPageResponseModel", type: MoviesResponseModel.self)
            else {
                XCTFail("TopRatedSecondPageResponseModel can not decoded")
                return
            }
            
            let data:Result<MoviesResponseModel,APIError> = .success(movieData)
            completion(data)
        }

    }
    
    func getMovieDetail(with id: String,
                        completion: @escaping (Result<MovieDetailResponseModel, APIError>) -> Void) {
        guard let movieData = Reader.read("MovieDetailResponse", type: MovieDetailResponseModel.self)
        else {
            XCTFail("MovieDetailResponse can not decoded")
            return
        }
        
        let data:Result<MovieDetailResponseModel,APIError> = .success(movieData)
        completion(data)
    }
    
}
