//
//  HomeViewMockPresenter.swift
//  MovieDBMVPTests
//
//  Created by Abdullah Onur Şimşek on 23.01.2024.
//

import Foundation
@testable import MovieDBMVP

final class HomeViewMockPresenter: HomeViewPresentationLogic {
    var fetchMoviesValue: Int = 0
    var fetchMoreMoviesValue: Int = 0
    var fetchMoviesWithTextValue: Int = 0
    var fetchMoreMoviesWithTextValue: Int = 0
    
    func fetchMovies() {
        fetchMoviesValue += 1
    }
    
    func fetchMoreMovies() {
        fetchMoreMoviesValue += 1
    }
    
    func fetchMovies(searchText: String) {
        fetchMoviesWithTextValue += 1
    }
    
    func fetchMoreMovies(searchText: String) {
        fetchMoreMoviesWithTextValue += 1
    }
    
}
