//
//  ViewController.swift
//  Wipro Assignment
//
//  Created by SAMBIT DASH on 30/07/20.
//  Copyright © 2020 SAMBIT DASH. All rights reserved.
//

import UIKit

class ViewController: BaseViewController {
    lazy var viewModel = FactsViewModel(datasource: self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        fetchData()
    }
    
    private func setupUI() {
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        self.tableView.dataSource = self
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.estimatedRowHeight = 100
        self.tableView.register(FactTableViewCell.self, forCellReuseIdentifier: "facts")
    }
    
    private func fetchData() {
        self.showLoader(with: "Loading...")
        viewModel.fetch()
    }


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.fact?.facts.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "facts", for: indexPath) as! FactTableViewCell
        cell.set(fact: viewModel.fact!.facts[indexPath.row])
        return cell
    }
    
}

extension ViewController: FactsDataSource {
    func didReceiveResponse() {
        self.dismissLoader()
        self.navigationItem.title = viewModel.fact?.title
        tableView.reloadData()
    }
    
    func didReceiveError() {
        self.dismissLoader()
        self.error = viewModel.error
    }
    
}
