//
//  HomePresenter.swift
//  MovieDBMVP
//
//  Created by Abdullah Onur Şimşek on 20.01.2024.
//

import Foundation

protocol HomeViewPresentationLogic: AnyObject {
    func fetchMovies()
    func fetchMoreMovies()
    func fetchMovies(searchText: String)
    func fetchMoreMovies(searchText: String)
}

final class HomeViewPresenter: HomeViewPresentationLogic {
    private let movieWorker: MovieWorker
    private let searchWorker: SearchWorker
    weak var controller: HomeViewDisplayLogic?
    
    private var task: DispatchWorkItem?
    private var pageNumber: Int = 1
    private var canLoadMore: Bool = true
    private var isLoadingMore: Bool = false
    
    init(movieWorker: MovieWorker,
         searchWorker: SearchWorker) {
        self.movieWorker = movieWorker
        self.searchWorker = searchWorker
    }
    
    private func performTask(_ task: DispatchWorkItem?) {
        guard let requestTask = task
        else { return }
        
        DispatchQueue.global(qos: .userInitiated).async(execute: requestTask)
    }
    
    func fetchMovies() {
        task?.cancel()
        self.pageNumber = 1
        task = .init {
            self.controller?.showLoading(isLoading: true)
            self.movieWorker.getTopRatedMoview(with: self.pageNumber) { [weak self] result in
                guard let self = self
                else { return }
                
                guard !(self.task?.isCancelled ?? false)
                else { return }
                
                switch result {
                case .success(let data):
                    guard let movieResult = data.results
                    else { return }
                    
                    if let totalPage = data.totalPages,
                       self.pageNumber < totalPage {
                        self.canLoadMore = true
                    } else {
                        self.canLoadMore = false
                    }
                    
                    let model: HomeViewDisplayModel = .init(data: movieResult)
                    controller?.display(model)
                    
                case .failure(let error):
                    controller?.display(error)
                    
                }
                
                self.controller?.showLoading(isLoading: false)
            }
            
        }
        
        performTask(task)
        
    }
    
    func fetchMoreMovies() {
        guard !isLoadingMore,
              canLoadMore
        else { return }
        
        isLoadingMore = true
        controller?.showLoading(isLoading: true)
        let requestPageNumber = pageNumber + 1
        movieWorker.getTopRatedMoview(with: requestPageNumber) { [weak self] result in
            guard let self = self
            else { return }
            
            switch result {
            case .success(let data):
                guard let movieResult = data.results
                else { return }
                
                self.pageNumber =  requestPageNumber
                if let totalPage = data.totalPages,
                   self.pageNumber < totalPage {
                    self.canLoadMore = true
                } else {
                    self.canLoadMore = false
                }
                
                controller?.display(movieResult)
                
            case .failure(let error):
                controller?.display(error)
                
            }
            
            self.isLoadingMore = false
            self.controller?.showLoading(isLoading: false)
            
        }
        
    }
    
    func fetchMovies(searchText: String) {
        task?.cancel()
        self.pageNumber = 1
        task = .init {
            self.controller?.showLoading(isLoading: true)
            self.searchWorker.searchMovie(page: self.pageNumber, 
                                          searchText: searchText) { [weak self] result in
                guard let self = self
                else { return }
                
                guard !(self.task?.isCancelled ?? false)
                else { return }
                
                switch result {
                case .success(let data):
                    guard let movieResult = data.results
                    else { return }
                    
                    if let totalPage = data.totalPages,
                       self.pageNumber < totalPage {
                        self.canLoadMore = true
                    } else {
                        self.canLoadMore = false
                    }
                    
                    let model: HomeViewDisplayModel = .init(data: movieResult)
                    controller?.display(model)
                    
                case .failure(let error):
                    controller?.display(error)
                    
                }
                
                self.controller?.showLoading(isLoading: false)
            }
            
        }
        
        performTask(task)
    }
    
    func fetchMoreMovies(searchText: String) {
        guard !isLoadingMore,
              canLoadMore
        else { return }
        
        isLoadingMore = true
        controller?.showLoading(isLoading: true)
        let requestPageNumber = pageNumber + 1
        searchWorker.searchMovie(page: requestPageNumber,
                                 searchText: searchText) { [weak self] result in
            guard let self = self
            else { return }
            
            switch result {
            case .success(let data):
                guard let movieResult = data.results
                else { return }
                
                self.pageNumber =  requestPageNumber
                if let totalPage = data.totalPages,
                   self.pageNumber < totalPage {
                    self.canLoadMore = true
                } else {
                    self.canLoadMore = false
                }
                
                controller?.display(movieResult)
                
            case .failure(let error):
                controller?.display(error)
                
            }
            
            self.isLoadingMore = false
            self.controller?.showLoading(isLoading: false)
            
        }
        
    }
    
}
