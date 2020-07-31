//
//  WAFactsViewModelTests.swift
//  Wipro AssignmentTests
//
//  Created by SAMBIT DASH on 31/07/20.
//  Copyright © 2020 SAMBIT DASH. All rights reserved.
//

import XCTest
@testable import Wipro_Assignment

class WAFactsViewModelTests: XCTestCase {
    lazy var viewModel: WAFactsViewModel = WAFactsViewModel(datasource: self)
    
    private var fetchExpectation: XCTestExpectation?
    
    func testFetch() {
        fetchExpectation = self.expectation(description: "fetchExpectation")
        viewModel.fetch()
        self.waitForExpectations(timeout: 10.0, handler: nil)
    }
}

extension WAFactsViewModelTests: WAFactsViewModelDelegate {
    func didReceiveResponse() {
        if let factsCount = viewModel.fact?.facts.count {
            XCTAssertGreaterThan(factsCount, 0)
            fetchExpectation?.fulfill()
        }
    }
    
    func didReceiveError() {
        fetchExpectation?.fulfill()
    }
    
    
}
