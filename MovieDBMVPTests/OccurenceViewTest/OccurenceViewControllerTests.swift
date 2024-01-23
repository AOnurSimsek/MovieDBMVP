//
//  OccurenceViewControllerTests.swift
//  MovieDBMVPTests
//
//  Created by Abdullah Onur Şimşek on 23.01.2024.
//

import XCTest
@testable import MovieDBMVP

final class OccurenceViewControllerTests: XCTestCase {
    private var sut: OccurenceViewController!
    private var presenter: OccurenceViewMockPresenter!
    
    override func setUp() {
        super.setUp()
        
        presenter = OccurenceViewMockPresenter()
        sut = OccurenceViewController(presenter: presenter)
    }
    
    func testViewDidLoad() {
        sut.loadViewIfNeeded()
        
        XCTAssertEqual(presenter.inputs.count, 1)
    }
    
    func testDisplayOccurenceData() {
        let model: [OccurenceModel] = [.init(character: "t", value: "2"),
                                       .init(character: "h", value: "2"),
                                       .init(character: "e", value: "2"),
                                       .init(character: "g", value: "1"),
                                       .init(character: "o", value: "1"),
                                       .init(character: "d", value: "1"),
                                       .init(character: "f", value: "1"),
                                       .init(character: "a", value: "1"),
                                       .init(character: "r", value: "1")]
        let displayData:OccurenceViewDisplayModel = .init(data: model,title: "The Godfather")
        sut.display(displayData)
        
        XCTAssertEqual(sut.tableView.numberOfSections, 1)
        XCTAssertEqual(sut.tableView.numberOfRows(inSection: 0), 10)
    }
    
    func testHeightForRowAt() {        
        let model: [OccurenceModel] = [.init(character: "t", value: "2"),
                                       .init(character: "h", value: "2"),
                                       .init(character: "e", value: "2"),
                                       .init(character: "g", value: "1"),
                                       .init(character: "o", value: "1"),
                                       .init(character: "d", value: "1"),
                                       .init(character: "f", value: "1"),
                                       .init(character: "a", value: "1"),
                                       .init(character: "r", value: "1")]
        let displayData:OccurenceViewDisplayModel = .init(data: model,title: "The Godfather")
        sut.display(displayData)
        
        let section: IndexPath = .init(row: 0, section: 0)
        let height = sut.tableView.delegate?.tableView?(sut.tableView, heightForRowAt: section)
        
        XCTAssertEqual(height, UITableView.automaticDimension)
    }
    
}
