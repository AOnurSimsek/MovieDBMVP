//
//  SearchWorker.swift
//  MovieDBMVP
//
//  Created by Abdullah Onur Şimşek on 20.01.2024.
//

import Foundation

protocol SearchWorker: AnyObject {
    func searchMovie(page: Int,
                     searchText: String,
                     completion: @escaping (Result<MoviesResponseModel, APIError>) -> Void)
}

final class SearchNetworkWorker: SearchWorker {
    private let service = APIService.shared

    func searchMovie(page: Int,
                     searchText: String,
                     completion: @escaping (Result<MoviesResponseModel, APIError>) -> Void) {
        guard let request = SearchEndpoint.movie(.init(query: searchText, page: page)).request
        else { return }
        
        service.makeRequest(with: request,
                            responseModel: MoviesResponseModel.self,
                            completion: completion)
    }
    
}
