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
    var responseNetworkExpectation: XCTestExpectation?
    var randomURLNetworkExpectation: XCTestExpectation?
    
    func testMakeServiceRequest() {
        self.networkExpectation = self.expectation(description: "serviceRequestException")
        
        do {
            let url = try WAURLBuilder(WANetworkConstantTest.baseURL).build()
            let networkManager = WANetworkManager<WAFactsResponseModel>(url: url, httpMethod: .get)
            networkManager.makeServiceRequest { (result) in
                switch result {
                    
                case .success(let response):
                    XCTAssert(response.facts.count > 0, WAConstantMessage.responseReceived)
                    self.networkExpectation?.fulfill()
                case .failure(_):
                    break
                }
            }
            
            waitForExpectations(timeout: 5.0, handler: nil)
            
        } catch {
            
        }
    }
    
    func testServiceResponse() {
        self.responseNetworkExpectation = self.expectation(description: "responseNetworkExpectation")
        
        do {
            let url = try WAURLBuilder(WANetworkConstantTest.baseURL).build()
            let networkManager = WANetworkManager<WAFactsResponseModel>(url: url, httpMethod: .get)
            networkManager.makeServiceRequest { (result) in
                switch result {
                    
                case .success(let response):
                    XCTAssert(response.facts.count > 0, WAConstantMessage.responseReceived)
                    XCTAssertEqual(response.title, WAConstantsTest.aboutCanada)
                    self.responseNetworkExpectation?.fulfill()
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
            _ = try WAURLBuilder(WANetworkConstantTest.emptyURL).build()
            
        } catch let error as WAError {
            XCTAssertEqual(error.message, WAConstantsTest.brokenURL)
        } catch {
            
        }
    }
    
    func testMakeServiceRequestWithRandomString() {
        do {
            let url = try WAURLBuilder(WANetworkConstantTest.randomURL).build()
            
            self.randomURLNetworkExpectation = self.expectation(description: "randomURLNetworkExpectation")
            
            let networkManager = WANetworkManager<WAFactsResponseModel>(url: url, httpMethod: .get)
            networkManager.makeServiceRequest { (result) in
                switch result {
                    
                case .success(_):
                    break
                case .failure(let error):
                    print(error.localizedDescription)
                    self.randomURLNetworkExpectation?.fulfill()
                }
            }
            
            waitForExpectations(timeout: 5.0, handler: nil)
            
        } catch {
            
        }
    }
}
