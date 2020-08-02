//
//  WAFactTableViewCell.swift
//  Wipro Assignment
//
//  Created by SAMBIT DASH on 30/07/20.
//  Copyright © 2020 SAMBIT DASH. All rights reserved.
//

import UIKit
import SDWebImage

class WAFactTableViewCell: UITableViewCell {
    var factTitleLabel: UILabel!
    var factDetailLabel: UILabel!
    var factImageView: UIImageView!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        
        // Set FactImageView
        factImageView = UIImageView()
        factImageView.layer.cornerRadius = 10
        factImageView.clipsToBounds = true
        self.contentView.addSubview(factImageView)
        
        factImageView.translatesAutoresizingMaskIntoConstraints = false
        factImageView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 15).isActive = true
        factImageView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 15).isActive = true
        self.contentView.bottomAnchor.constraint(greaterThanOrEqualTo: factImageView.bottomAnchor, constant: 15).isActive = true
        factImageView.widthAnchor.constraint(equalToConstant: 130).isActive = true
        factImageView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        // Set Fact Title Label
        factTitleLabel = UILabel()
        if #available(iOS 13.0, *) {
            factTitleLabel.textColor = .label
        } else {
            factTitleLabel.textColor = .black
        }
        factTitleLabel.font = .systemFont(ofSize: 18)
        factTitleLabel.numberOfLines = 0
        factTitleLabel.lineBreakMode = .byWordWrapping
        self.contentView.addSubview(factTitleLabel)
        
        factTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        factTitleLabel.leadingAnchor.constraint(equalTo: factImageView.trailingAnchor, constant: 15).isActive = true
        factTitleLabel.topAnchor.constraint(equalTo: factImageView.topAnchor).isActive = true
        self.contentView.trailingAnchor.constraint(equalTo: factTitleLabel.trailingAnchor, constant: 15).isActive = true
        
        // Set Fact Detail Label
        factDetailLabel = UILabel()
        if #available(iOS 13.0, *) {
            factDetailLabel.textColor = .secondaryLabel
        } else {
            factDetailLabel.textColor = .gray
        }
        factDetailLabel.numberOfLines = 0
        factDetailLabel.lineBreakMode = .byWordWrapping
        factDetailLabel.font = .systemFont(ofSize: 15)
        self.contentView.addSubview(factDetailLabel)
        
        factDetailLabel.translatesAutoresizingMaskIntoConstraints = false
        factDetailLabel.leadingAnchor.constraint(equalTo: factTitleLabel.leadingAnchor).isActive = true
        factDetailLabel.topAnchor.constraint(equalTo: factTitleLabel.bottomAnchor, constant: 5).isActive = true
        factDetailLabel.trailingAnchor.constraint(equalTo: factTitleLabel.trailingAnchor, constant: 15).isActive = true
        self.contentView.bottomAnchor.constraint(equalTo: factDetailLabel.bottomAnchor, constant: 15).isActive = true
        factDetailLabel.setContentHuggingPriority(UILayoutPriority(250), for: .horizontal)
    }
    
    /// Set Fact
    /// - Parameter fact: instance of WAFactModel
    func set(fact: WAFactModel) {
        factTitleLabel.text = fact.title
        factDetailLabel.text = fact.detail
        
        if let imageURL = URL(string: fact.image) {
            factImageView.sd_imageIndicator = SDWebImageActivityIndicator.grayLarge
            factImageView.sd_setImage(with: imageURL, placeholderImage: #imageLiteral(resourceName: "placeholder"))
        } else {
            factImageView.image = #imageLiteral(resourceName: "placeholder")
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
