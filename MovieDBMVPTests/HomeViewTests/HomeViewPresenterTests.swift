//
//  HomeViewPresenterTests.swift
//  MovieDBMVPTests
//
//  Created by Abdullah Onur Şimşek on 23.01.2024.
//

import XCTest
@testable import MovieDBMVP

final class HomeViewPresenterTests: XCTestCase {
    private var controller: HomeViewMockController!
    private var sut: HomeViewPresenter!
    private var movieWorker: MockMovieWorker!
    private var searchWorker: MockSearchWorker!
    
    override func setUp() {
        super.setUp()
        movieWorker = MockMovieWorker()
        searchWorker = MockSearchWorker()
        controller = HomeViewMockController()
        sut = HomeViewPresenter(movieWorker: movieWorker, 
                                searchWorker: searchWorker)
        sut.controller = controller
    }
    
    func testFetchMovies() {
        guard let data = Reader.read("TopRatedResponseModel", type: MoviesResponseModel.self)
        else {
            XCTFail("TopRatedResponseModel can not decoded")
            return
        }
        let displayModel: HomeViewDisplayModel = .init(data: data.results ?? [])
        
        sut.fetchMovies()
        sleep(3)
        
        XCTAssertEqual(controller.loadingVisibilty.count, 2)
        XCTAssertEqual(controller.loadingVisibilty.first, true)
        XCTAssertEqual(controller.loadingVisibilty.last, false)
        
        XCTAssertEqual(controller.movieDisplayModel.count, 1)
        XCTAssertEqual(controller.movieDisplayModel.first, displayModel)
    }
    
    func testFetchMoreMovies() {
        guard let data = Reader.read("TopRatedSecondPageResponseModel", type: MoviesResponseModel.self)
        else {
            XCTFail("TopRatedSecondPageResponseModel can not decoded")
            return
        }
        let displayModel: HomeViewDisplayModel = .init(data: data.results ?? [])
    
        sut.fetchMovies()
        sleep(3)
        sut.fetchMoreMovies()
        sleep(3)
    
        XCTAssertEqual(controller.loadingVisibilty.count, 4)
        XCTAssertEqual(controller.loadingVisibilty[0], true)
        XCTAssertEqual(controller.loadingVisibilty[1], false)
        XCTAssertEqual(controller.loadingVisibilty[2], true)
        XCTAssertEqual(controller.loadingVisibilty[3], false)
    
        XCTAssertEqual(controller.movieDisplayModel.count, 2)
        XCTAssertEqual(controller.movieDisplayModel.last?.getAllData().count, 40)
        XCTAssertEqual(controller.movieDisplayModel.last?.getAllData().last, displayModel.getAllData().last)
    }
    
    func testServiceFailure() {
        let error: APIError = .unknownError("An unkown error")
        sut.controller?.display(error)
    
        XCTAssertEqual(controller.alerts.count, 1)
        XCTAssertEqual(controller.alerts.first, error)
        XCTAssertEqual(controller.alerts.first?.description, error.description)
    }
    
    func testSearchMovies() {
        guard let data = Reader.read("SearchResponseModel", type: MoviesResponseModel.self)
        else {
            XCTFail("SearchResponseModel can not decoded")
            return
        }
        let displayModel: HomeViewDisplayModel = .init(data: data.results ?? [])
        
        sut.fetchMovies(searchText: "Spiderman")
        sleep(3)

        XCTAssertEqual(controller.loadingVisibilty.count, 2)
        XCTAssertEqual(controller.loadingVisibilty.first, true)
        XCTAssertEqual(controller.loadingVisibilty.last, false)
        
        XCTAssertEqual(controller.movieDisplayModel.count, 1)
        XCTAssertEqual(controller.movieDisplayModel.first, displayModel)
    }
    
    func testSearchMoreMovies() {
        guard let data = Reader.read("TopRatedSecondPageResponseModel", type: MoviesResponseModel.self)
        else {
            XCTFail("TopRatedSecondPageResponseModel can not decoded")
            return
        }
        let displayModel: HomeViewDisplayModel = .init(data: data.results ?? [])
    
        sut.fetchMovies(searchText: "Spiderman")
        sleep(3)
        sut.fetchMoreMovies(searchText: "Spiderman")
        sleep(3)
    
        XCTAssertEqual(controller.loadingVisibilty.count, 4)
        XCTAssertEqual(controller.loadingVisibilty[0], true)
        XCTAssertEqual(controller.loadingVisibilty[1], false)
        XCTAssertEqual(controller.loadingVisibilty[2], true)
        XCTAssertEqual(controller.loadingVisibilty[3], false)
    
        XCTAssertEqual(controller.movieDisplayModel.count, 2)
        XCTAssertEqual(controller.movieDisplayModel.last?.getAllData().count, 40)
        XCTAssertEqual(controller.movieDisplayModel.last?.getAllData().last, displayModel.getAllData().last)
    }
    
}
