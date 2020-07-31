//
//  WANetworkManagerTests.swift
//  Wipro AssignmentTests
//
//  Created by SAMBIT DASH on 31/07/20.
//  Copyright © 2020 SAMBIT DASH. All rights reserved.
//

import XCTest
@testable import Wipro_Assignment

class WANetworkManagerTests: XCTestCase {

    var networkExpectation: XCTestExpectation?
    var noURLNetworkExpectation: XCTestExpectation?
    var randomURLNetworkExpectation: XCTestExpectation?
    
    func testMakeServiceRequest() {
        self.networkExpectation = self.expectation(description: "serviceRequestException")
        
        do {
            let url = try WAURLBuilder(NetworkConstant.baseURL).build()
            let networkManager = WANetworkManager<WAFactsResponseModel>(url: url, httpMethod: .get)
            networkManager.makeServiceRequest { (result) in
                switch result {
                    
                case .success(let response):
                    XCTAssert(response.facts.count > 0, "Response received")
                    self.networkExpectation?.fulfill()
                case .failure(_):
                    break
                }
            }
            
            waitForExpectations(timeout: 5.0, handler: nil)
            
        } catch {
            
        }
    }
    
    func testMakeServiceRequestWithOutURL() {
        do {
            let url = try WAURLBuilder("").build()
            
            self.noURLNetworkExpectation = self.expectation(description: "serviceRequestException")
            
            let networkManager = WANetworkManager<WAFactsResponseModel>(url: url, httpMethod: .get)
            networkManager.makeServiceRequest { (result) in
                switch result {
                    
                case .success(_):
                    break
                case .failure(let error):
                    print(error.localizedDescription)
                    self.noURLNetworkExpectation?.fulfill()
                }
            }
            
            waitForExpectations(timeout: 5.0, handler: nil)
            
        } catch let error as WAError {
            XCTAssertEqual(error.message, "Unable to fetch data. URL is broken")
            self.noURLNetworkExpectation?.fulfill()
        } catch {
            
        }
    }
    
    func testMakeServiceRequestWithRandomString() {
        do {
            let url = try WAURLBuilder("example.com").build()
            
            self.randomURLNetworkExpectation = self.expectation(description: "randomURLNetworkExpectation")
            
            let networkManager = WANetworkManager<WAFactsResponseModel>(url: url, httpMethod: .get)
            networkManager.makeServiceRequest { (result) in
                switch result {
                    
                case .success(_):
                    break
                case .failure(let error):
                    print(error.localizedDescription)
                    self.noURLNetworkExpectation?.fulfill()
                }
            }
            
            waitForExpectations(timeout: 5.0, handler: nil)
            
        } catch {
            
        }
    }
}
