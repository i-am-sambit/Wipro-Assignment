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
        
    }


}

extension ViewController: FactsDataSource {
    func didReceiveResponse() {
        
    }
    
    func didReceiveError() {
        
    }
    
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "facts", for: indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
