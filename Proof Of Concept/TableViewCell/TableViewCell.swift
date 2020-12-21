//
//  TableViewCell.swift
//  Proof Of Concept
//
//  Created by Raghu on 21/12/20.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    // titleLabel
    let titleLabel:UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = UIFont(name: "AvenirNext-DemiBold", size: 16)
        return label
    }()
    // descriptionLabel
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = UIFont(name: "Avenir-Book", size: 14)
        return label
    }()
    // image
    let img: UIImageView =  {
        let img = UIImageView()
        img.backgroundColor = .black
        img.contentMode = .scaleAspectFill
        img.translatesAutoresizingMaskIntoConstraints = false
        img.layer.cornerRadius = 13
        img.clipsToBounds = true
        return img
    }()
        
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        // configure titleLabel
        let marginGuide = contentView.layoutMarginsGuide
        // configure img
        contentView.addSubview(img)
        img.widthAnchor.constraint(equalToConstant:50).isActive = true
        img.heightAnchor.constraint(equalToConstant:50).isActive = true
        img.leadingAnchor.constraint(equalTo: marginGuide.leadingAnchor).isActive = true
        img.topAnchor.constraint(equalTo: marginGuide.topAnchor).isActive = true
        // configure titleLabel
        contentView.addSubview(titleLabel)
        titleLabel.leadingAnchor.constraint(equalTo: img.trailingAnchor, constant: 10).isActive = true
        //titleLabel.leadingAnchor.constraint(equalTo: img.trailingAnchor).isActive = true
        titleLabel.topAnchor.constraint(equalTo: img.topAnchor).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: marginGuide.trailingAnchor).isActive = true
        // configure descriptionLabel
        contentView.addSubview(descriptionLabel)
        descriptionLabel.leadingAnchor.constraint(equalTo: marginGuide.leadingAnchor).isActive = true
        descriptionLabel.bottomAnchor.constraint(equalTo: marginGuide.bottomAnchor).isActive = true
        descriptionLabel.trailingAnchor.constraint(equalTo: marginGuide.trailingAnchor).isActive = true
        descriptionLabel.topAnchor.constraint(equalTo: img.bottomAnchor).isActive = true
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        self.img.image = nil
        // Set cell to initial state here, reset or set values
    }
}
