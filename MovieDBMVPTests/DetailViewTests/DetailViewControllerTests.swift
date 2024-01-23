//
//  DetailViewControllerTests.swift
//  MovieDBMVPTests
//
//  Created by Abdullah Onur Şimşek on 22.01.2024.
//

import XCTest
@testable import MovieDBMVP

final class DetailViewControllerTests: XCTestCase {
    private var sut: DetailViewController!
    private var presenter: DetailViewMockPresenter!
    private var router: DetailViewMockRouter!
    
    override func setUp() {
        super.setUp()
        
        presenter = DetailViewMockPresenter()
        router = DetailViewMockRouter()
        sut = DetailViewController(presenter: presenter, 
                                   router: router)
    }
    
    func testViewDidLoad() {
        sut.loadViewIfNeeded()
        
        XCTAssertEqual(presenter.inputs.count, 1)
    }
    
    func testDisplayMovieDetail() {
        guard let movieData = Reader.read("MovieDetailResponse", type: MovieDetailResponseModel.self)
        else {
            XCTFail("MovieDetailResponse can not decoded")
            return
        }
        
        let displayData: DetailViewDisplayModel = .init(data: movieData)
        sut.display(displayData)
        
        XCTAssertEqual(sut.tableView.numberOfSections, 6)
        XCTAssertEqual(sut.tableView.numberOfRows(inSection: 0), 1)
        XCTAssertEqual(sut.tableView.numberOfRows(inSection: 1), 1)
        XCTAssertEqual(sut.tableView.numberOfRows(inSection: 2), 1)
        XCTAssertEqual(sut.tableView.numberOfRows(inSection: 3), 1)
        XCTAssertEqual(sut.tableView.numberOfRows(inSection: 4), 1)
        XCTAssertEqual(sut.tableView.numberOfRows(inSection: 5), 1)
    }
    
    func testHeightForRowAt() {
        guard let movieData = Reader.read("MovieDetailResponse", type: MovieDetailResponseModel.self)
        else {
            XCTFail("MovieDetailResponse can not decoded")
            return
        }
        
        let displayData: DetailViewDisplayModel = .init(data: movieData)
        sut.display(displayData)
        
        let section: IndexPath = .init(row: 0, section: 0)
        let height = sut.tableView.delegate?.tableView?(sut.tableView, heightForRowAt: section)
        
        XCTAssertEqual(height, UITableView.automaticDimension)
    }
    
    func testDisplayError() {
        let error: APIError = .unknownError("An unknown error occured")
        sut.display(error)
        
        XCTAssertEqual(sut.tableView.numberOfSections, 0)
    }
    
    func testDidSelect() {
        guard let movieData = Reader.read("MovieDetailResponse", type: MovieDetailResponseModel.self)
        else {
            XCTFail("MovieDetailResponse can not decoded")
            return
        }
        
        let displayData: DetailViewDisplayModel = .init(data: movieData)
        sut.display(displayData)
        
        let section: IndexPath = .init(row: 0, section: 5)
        sut.tableView.delegate?.tableView?(sut.tableView, didSelectRowAt: section)
        
        XCTAssertEqual(router.routeToImdb, 1)
    }
    
}
