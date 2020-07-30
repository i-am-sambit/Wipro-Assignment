//
//  BaseViewController.swift
//  Wipro Assignment
//
//  Created by SAMBIT DASH on 30/07/20.
//  Copyright © 2020 SAMBIT DASH. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    var error: Error? {
        didSet {
            guard let unwrappedError = error else { return }
            self.show(alert: .error(message: unwrappedError.localizedDescription))
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    private func show(alert: Alert) {
        var alertTitle: String
        var alertMessage: String
        
        switch alert {
            
        case .success(message: let message):
            alertTitle = "Success"
            alertMessage = message
        case .info(message: let message):
            alertTitle = "Alert"
            alertMessage = message
        case .error(message: let message):
            alertTitle = "Error"
            alertMessage = message
        }
        
        let alertController = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }
}

