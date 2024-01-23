//
//  DetailViewPresenter.swift
//  MovieDBMVP
//
//  Created by Abdullah Onur Şimşek on 22.01.2024.
//

import Foundation

protocol DetailViewPresentationLogic: AnyObject {
    func fetchMovieDetail()
}

final class DetailViewPresenter: DetailViewPresentationLogic {
    weak var controller: DetailViewDisplayLogic?
    private var movieWorker: MovieWorker
    private var movieId: String
    
    init(movieWorker: MovieWorker,
         movieId: String) {
        self.movieWorker = movieWorker
        self.movieId = movieId
    }
    
    func fetchMovieDetail() {
        controller?.showLoading(isLoading: true)
        movieWorker.getMovieDetail(with: movieId) { [weak self] result in
            guard let self = self
            else { return }
            
            switch result {
            case .success(let data):
                let model: DetailViewDisplayModel = .init(data: data)
                controller?.display(model)
                
            case .failure(let error):
                controller?.display(error)
                
            }
            
            controller?.showLoading(isLoading: false)
            
        }
        
    }
    
}
