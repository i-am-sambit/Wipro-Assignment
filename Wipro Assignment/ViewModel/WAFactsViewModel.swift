//
//  FactsViewModel.swift
//  Wipro Assignment
//
//  Created by SAMBIT DASH on 30/07/20.
//  Copyright © 2020 SAMBIT DASH. All rights reserved.
//

import Foundation

protocol WAFactsViewModelDelegate: class {
    func didReceiveResponse()
    func didReceiveError()
}

class WAFactsViewModel {
    private(set) var fact: WAFactsResponseModel? {
        didSet {
            delegate?.didReceiveResponse()
        }
    }
    private(set) var error: WAError? {
        didSet {
            delegate?.didReceiveError()
        }
    }
    
    weak var delegate: WAFactsViewModelDelegate?
    
    init(datasource: WAFactsViewModelDelegate?) {
        self.delegate = datasource
    }
    
    func fetch() {
        do {
            let url = try WAURLBuilder(NetworkConstant.baseURL).build()
            WANetworkManager<WAFactsResponseModel>(url: url, httpMethod: .get).makeServiceRequest { (result) in
                DispatchQueue.main.async {
                    switch result {
                        
                    case .success(let response):
                        self.fact = response
                    case .failure(let error):
                        self.error = error
                    }
                }
            }
        } catch let error as WAError {
            self.error = error
        } catch {
            self.error = WAError.validation(message: error.localizedDescription)
        }
    }
}
