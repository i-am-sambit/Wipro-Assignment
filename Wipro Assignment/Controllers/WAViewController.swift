//
//  WAViewController.swift
//  Wipro Assignment
//
//  Created by SAMBIT DASH on 30/07/20.
//  Copyright © 2020 SAMBIT DASH. All rights reserved.
//

import UIKit

class WAViewController: WABaseViewController {
    lazy var viewModel = WAFactsViewModel(datasource: self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        fetchData()
    }
    
    internal override func setupUI() {
        super.setupUI()
        
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        self.tableView.dataSource = self
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.estimatedRowHeight = 100
        self.tableView.register(WAFactTableViewCell.self, forCellReuseIdentifier: WAFactTableViewCell.identifier)
        
        self.refreshControl?.addTarget(self, action: #selector(refreshControllAction(_:)), for: .valueChanged)
    }
    
    private func fetchData() {
        self.showLoader(with: "Loading...")
        viewModel.fetch()
    }
    
    @objc func refreshControllAction(_ controll: UIRefreshControl) {
        viewModel.fetch()
        refreshControl?.beginRefreshing()
    }


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.fact?.facts.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: WAFactTableViewCell.identifier, for: indexPath) as! WAFactTableViewCell
        cell.set(fact: viewModel.fact!.facts[indexPath.row])
        return cell
    }
    
}

extension WAViewController: WAFactsViewModelDelegate {
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
