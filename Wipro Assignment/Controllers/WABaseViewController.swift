//
//  WABaseViewController.swift
//  Wipro Assignment
//
//  Created by SAMBIT DASH on 30/07/20.
//  Copyright © 2020 SAMBIT DASH. All rights reserved.
//

import UIKit
import JGProgressHUD

class WABaseViewController: UITableViewController {

    var error: WAError? {
        didSet {
            guard let unwrappedError = error else { return }
            self.show(alert: .error(message: unwrappedError.message))
        }
    }
    
    private var progressHud: JGProgressHUD?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    func setupUI() {
        self.refreshControl = UIRefreshControl()
        self.refreshControl?.attributedTitle = NSAttributedString(string: "Refreshing...")
    }
    
    final func showLoader(with message: String) {
        progressHud = JGProgressHUD(style: .dark)
        progressHud?.textLabel.text = message
        progressHud?.detailTextLabel.text = ""
        progressHud?.show(in: self.view)
    }
    
    final func dismissLoader() {
        progressHud?.dismiss()
        self.refreshControl?.endRefreshing()
    }
    
    
    /// Show Alert
    ///
    /// Invoke this method, when you want to show an alert
    /// - Parameter alert: an WAAlert instance, with message
    final func show(alert: WAAlert) {
        var alertTitle: String
        var alertMessage: String
        
        switch alert {
            
        case .success(message: let message):
            alertTitle = WAAlertConstant.success
            alertMessage = message
        case .info(message: let message):
            alertTitle = WAAlertConstant.info
            alertMessage = message
        case .error(message: let message):
            alertTitle = WAAlertConstant.error
            alertMessage = message
        }
        
        let alertController = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }
}

