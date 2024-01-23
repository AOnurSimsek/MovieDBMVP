//
//  OccurenceViewPresenterTests.swift
//  MovieDBMVPTests
//
//  Created by Abdullah Onur Şimşek on 23.01.2024.
//

import XCTest
@testable import MovieDBMVP

final class OccurenceViewPresenterTests: XCTestCase {
    private var controller: OccurenceViewMockController!
    private var sut: OccurenceViewPresenter!
    
    override func setUp() {
        super.setUp()
        
        controller = OccurenceViewMockController()
        sut = OccurenceViewPresenter(title: "The Godfather")
        sut.controller = controller
    }
    
    func testCalculateOccurence() {
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
        
        sut.calculateOccurence()
        
        XCTAssertEqual(controller.loadingVisibilty.count, 2)
        XCTAssertEqual(controller.loadingVisibilty.first, true)
        XCTAssertEqual(controller.loadingVisibilty.last, false)
        
        XCTAssertEqual(controller.occurenceData.count, 1)
        XCTAssertEqual(controller.occurenceData.first, displayData)
    }
    
}
