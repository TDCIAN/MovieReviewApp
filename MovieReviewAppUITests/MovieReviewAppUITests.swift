//
//  MovieReviewAppUITests.swift
//  MovieReviewAppUITests
//
//  Created by JeongminKim on 2022/03/17.
//

import XCTest

@testable import MovieReviewApp

class MovieReviewAppUITests: XCTestCase {
    var app: XCUIApplication!
    
    override func setUp() {
        super.setUp()
        
        continueAfterFailure = false // 실패하면 기동을 끝내겠다
        
        app = XCUIApplication()
        app.launch()
    }
    
    override func tearDown() {
        super.tearDown()
        
        app = nil
    }
    
    func test_navigationBar의_title이_영화평점으로_설정되어있다() {
        let existNavigationBar = app.navigationBars["영화 평점"].exists
        XCTAssertTrue(existNavigationBar)
    }
    
    func test_searchBar가_존재한다() {
        let existSearchBar = app.navigationBars["영화 평점"]
            .searchFields["Search"]
            .exists
        
        XCTAssertTrue(existSearchBar)
    }
    
    func test_searchBar에_cancelButton이_존재한다() {
        let navigationBar = app.navigationBars["영화 평점"]
        navigationBar
            .searchFields["Search"]
            .tap()
        
        let existSearchBarCancelButton = navigationBar
            .buttons["Cancel"]
            .exists
        
        XCTAssertTrue(existSearchBarCancelButton)
    }
}
