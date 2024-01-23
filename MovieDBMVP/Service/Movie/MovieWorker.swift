//
//  MovieWorker.swift
//  MovieDBMVP
//
//  Created by Abdullah Onur Şimşek on 19.01.2024.
//

import Foundation

protocol MovieWorker: AnyObject {
    func getTopRatedMoview(with page: Int,
                           completion: @escaping (Result<MoviesResponseModel, APIError>) -> Void)
    func getMovieDetail(with id: String,
                        completion: @escaping (Result<MovieDetailResponseModel, APIError>) -> Void)
}

final class MovieNetworkWorker: MovieWorker {
    private let service = APIService.shared

    func getTopRatedMoview(with page: Int,
                           completion: @escaping (Result<MoviesResponseModel, APIError>) -> Void) {
        guard let request = MovieEndpoint.topRatedMovie(.init(page: page)).request
        else { return }
        
        service.makeRequest(with: request,
                            responseModel: MoviesResponseModel.self,
                            completion: completion)
    }
    
    func getMovieDetail(with id: String, 
                        completion: @escaping (Result<MovieDetailResponseModel, APIError>) -> Void) {
        guard let request = MovieEndpoint.movieDetail(id).request
        else { return }
        
        service.makeRequest(with: request,
                            responseModel: MovieDetailResponseModel.self,
                            completion: completion)
    }
    
}
