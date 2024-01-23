//
//  DetailViewPresenterTests.swift
//  MovieDBMVPTests
//
//  Created by Abdullah Onur Şimşek on 22.01.2024.
//

import XCTest
@testable import MovieDBMVP

final class DetailViewPresenterTests: XCTestCase {
    private var controller: DetailViewMockController!
    private var sut: DetailViewPresenter!
    private var worker: MockMovieWorker!
    
    override func setUp() {
        super.setUp()
        worker = MockMovieWorker()
        controller = DetailViewMockController()
        sut = DetailViewPresenter(movieWorker: worker,
                                  movieId: "12")
        sut.controller = controller
    }
    
    func testFetchMovieDetail() {
        guard let movieData = Reader.read("MovieDetailResponse", type: MovieDetailResponseModel.self)
        else {
            XCTFail("MockCharactersReponseModel can not decoded")
            return
        }
        let displayModel: DetailViewDisplayModel = .init(data: movieData)
        
        sut.fetchMovieDetail()
        
        XCTAssertEqual(controller.loadingVisibilty.count, 2)
        XCTAssertEqual(controller.loadingVisibilty.first, true)
        XCTAssertEqual(controller.loadingVisibilty.last, false)
        
        XCTAssertEqual(controller.movieDetails.count, 1)
        XCTAssertEqual(controller.movieDetails.first, displayModel)
        XCTAssertEqual(controller.movieDetails.first?.getImdbId(), "tt0266543")
    }
    
    func testFetchMovieDetailFailure() {
        let error: APIError = .unknownError("An unkown error")
        sut.controller?.display(error)
        
        XCTAssertEqual(controller.alerts.count, 1)
        XCTAssertEqual(controller.alerts.first, error)
        XCTAssertEqual(controller.alerts.first?.description, error.description)
    }
    
}
