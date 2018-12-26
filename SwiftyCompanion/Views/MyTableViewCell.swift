//
//  MyTableViewCell.swift
//  SwiftyCompanion
//
//  Created by Ruslan on 11.11.2018.
//  Copyright © 2018 Ruslan NAUMENKO. All rights reserved.
//

import UIKit

class MyTableViewCell: UITableViewCell {
    
    var model: CellModel? {
        didSet {
            projectLabel.text = model?.projectName
            markLabel.text = model?.projectMark
            markLabel.textColor = (model?.validated == 1 ? .green : .red)
            markLabel.sizeToFit()
            markLabel.updateConstraintsIfNeeded()
        }
    }
    
    private let projectLabel: UILabel = {
        let label = UILabel()
        
        label.numberOfLines = 2
        label.lineBreakMode = .byWordWrapping
        label.textColor = UIColor(red: 30/255, green: 186/255, blue: 187/255, alpha: 1.0)
        label.font = UIFont.boldSystemFont(ofSize: 20.0)
        label.textAlignment = .left
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    private let markLabel: UILabel = {
        let label = UILabel()
        
        label.font = UIFont.boldSystemFont(ofSize: 20.0)
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private func addConstraints() {
        projectLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        projectLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16).isActive = true
        projectLabel.trailingAnchor.constraint(lessThanOrEqualTo: markLabel.leadingAnchor, constant: -8).isActive = true
        
        markLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        markLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16).isActive = true
        
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(projectLabel)
        contentView.addSubview(markLabel)
        
        addConstraints()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    override func updateConstraints() {
        super.updateConstraints()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
