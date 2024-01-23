//
//  HomeViewControllerTests.swift
//  MovieDBMVPTests
//
//  Created by Abdullah Onur Şimşek on 23.01.2024.
//

import XCTest
@testable import MovieDBMVP

final class HomeViewControllerTests: XCTestCase {
    private var sut: HomeViewController!
    private var presenter: HomeViewMockPresenter!
    private var router: HomeViewMockRouter!
    
    override func setUp() {
        super.setUp()
        
        presenter = HomeViewMockPresenter()
        router = HomeViewMockRouter()
        sut = HomeViewController(presenter: presenter,
                                 router: router)
    }
    
    func testViewDidLoad() {
        sut.loadViewIfNeeded()
        
        XCTAssertEqual(presenter.fetchMoviesValue, 1)
    }
    
    func testDisplayMovies() {
        guard let movieData = Reader.read("TopRatedResponseModel", type: MoviesResponseModel.self)
        else {
            XCTFail("TopRatedResponseModel can not decoded")
            return
        }
        
        let displayData: HomeViewDisplayModel = .init(data: movieData.results ?? [])
        sut.display(displayData)
        
        XCTAssertEqual(sut.collectionView.numberOfSections, 1)
        XCTAssertEqual(sut.collectionView.numberOfItems(inSection: 0), 20)
    }
    
    func testDisplayMoreMovies() {
        guard let movieData = Reader.read("TopRatedResponseModel", type: MoviesResponseModel.self),
              let secondMovieData = Reader.read("TopRatedSecondPageResponseModel", type: MoviesResponseModel.self)
        else {
            XCTFail("TopRatedResponseModels can not decoded")
            return
        }
        
        let displayData: HomeViewDisplayModel = .init(data: movieData.results ?? [])
        sut.display(displayData)
        let secondDisplayData: [MovieResultResponseModel] = secondMovieData.results ?? []
        sut.display(secondDisplayData)
        
        XCTAssertEqual(sut.collectionView.numberOfSections, 1)
        XCTAssertEqual(sut.collectionView.numberOfItems(inSection: 0), 40)
    }
    
    func testSearchMovies() {
        guard let movieData = Reader.read("SearchResponseModel", type: MoviesResponseModel.self)
        else {
            XCTFail("SearchResponseModel can not decoded")
            return
        }
        let displayData: HomeViewDisplayModel = .init(data: movieData.results ?? [])
        
        sut.searchBar.delegate?.searchBar?(sut.searchBar, textDidChange: "Spiderman")
        sut.display(displayData)

        XCTAssertEqual(sut.searchText, "Spiderman")
        XCTAssertEqual(presenter.fetchMoviesWithTextValue, 1)
        XCTAssertEqual(sut.collectionView.numberOfSections, 1)
        XCTAssertEqual(sut.collectionView.numberOfItems(inSection: 0), 20)
    }
    
    func testFetchMoreMovies() {
        guard let movieData = Reader.read("TopRatedResponseModel", type: MoviesResponseModel.self)
        else {
            XCTFail("TopRatedResponseModels can not decoded")
            return
        }
        
        sut.loadViewIfNeeded()
        let displayData: HomeViewDisplayModel = .init(data: movieData.results ?? [])
        sut.display(displayData)

        let indexPath = IndexPath(row: 19, section: 0)
        sut.collectionView.delegate?.collectionView?(sut.collectionView,
                                                     willDisplay: MovieCollectionViewCell(),
                                                     forItemAt: indexPath)

        XCTAssertEqual(presenter.fetchMoreMoviesValue, 1)
    }
    
    func testFetchMoreMoviesWithSearch() {
        guard let movieData = Reader.read("SearchResponseModel", type: MoviesResponseModel.self)
        else {
            XCTFail("SearchResponseModel can not decoded")
            return
        }
        
        sut.loadViewIfNeeded()
        
        sut.searchText = "Spiderman"
        let displayData: HomeViewDisplayModel = .init(data: movieData.results ?? [])
        sut.display(displayData)

        let indexPath = IndexPath(row: 19, section: 0)
        sut.collectionView.delegate?.collectionView?(sut.collectionView,
                                                     willDisplay: MovieCollectionViewCell(),
                                                     forItemAt: indexPath)
        
        XCTAssertEqual(presenter.fetchMoreMoviesWithTextValue, 1)
    }
    
    func testEmptySearch() {
        sut.searchBar.delegate?.searchBar?(sut.searchBar, textDidChange: "")

        XCTAssertEqual(sut.searchText, nil)
        XCTAssertEqual(presenter.fetchMoviesValue, 1)
    }
    
    func testSearchCleared() {
        guard let textfield = sut.searchBar.value(forKey: "searchField") as? UITextField,
              let movieData = Reader.read("TopRatedResponseModel", type: MoviesResponseModel.self)
        else {
            XCTFail("testSearchCleared can not pass guard")
            return
        }
        
        let displayData: HomeViewDisplayModel = .init(data: movieData.results ?? [])
        
        let _ = textfield.delegate?.textFieldShouldClear?(textfield)
        sut.display(displayData)
        
        XCTAssertEqual(sut.searchText, nil)
        XCTAssertEqual(presenter.fetchMoviesValue, 1)
        XCTAssertEqual(sut.collectionView.numberOfSections, 1)
        XCTAssertEqual(sut.collectionView.numberOfItems(inSection: 0), 20)
    }
    
    func testDisplayError() {
        let error: APIError = .unknownError("An unknown error occured")
        sut.display(error)
        
        XCTAssertEqual(sut.collectionView.numberOfItems(inSection: 0), 0)
    }
    
    func testDidSelect() {
        guard let movieData = Reader.read("SearchResponseModel", type: MoviesResponseModel.self)
        else {
            XCTFail("SearchResponseModel can not decoded")
            return
        }
        
        let displayData: HomeViewDisplayModel = .init(data: movieData.results ?? [])
        sut.display(displayData)
        
        let section: IndexPath = .init(row: 0, section: 0)
        sut.collectionView.delegate?.collectionView?(sut.collectionView, didSelectItemAt: section)
        
        XCTAssertEqual(router.routeToDetail, 1)
    }
    
    func testOccurenceSelection() {
        sut.didPressCharacterOccurence(title: "The Godfather")
        
        XCTAssertEqual(router.routeToOccurence, 1)
    }
    
}
