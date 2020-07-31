//
//  FactsViewModel.swift
//  Wipro Assignment
//
//  Created by SAMBIT DASH on 30/07/20.
//  Copyright © 2020 SAMBIT DASH. All rights reserved.
//

import Foundation

protocol FactsDataSource: class {
    func didReceiveResponse()
    func didReceiveError()
}

class FactsViewModel {
    private(set) var fact: FactsResponseModel? {
        didSet {
            delegate?.didReceiveResponse()
        }
    }
    private(set) var error: Error? {
        didSet {
            delegate?.didReceiveError()
        }
    }
    
    weak var delegate: FactsDataSource?
    
    init(datasource: FactsDataSource?) {
        self.delegate = datasource
    }
    
    func fetch() {
        guard let url = URL(string: "https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/facts.json") else { return }
        NetworkManager<FactsResponseModel>(url: url, type: .get).request { (result) in
            DispatchQueue.main.async {
                switch result {
                    
                case .success(let response):
                    self.fact = response
                case .failure(let error):
                    self.error = error
                }
            }
        }
    }
}
