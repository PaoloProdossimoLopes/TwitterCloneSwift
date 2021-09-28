//
//  FindUserCell.swift
//  TwitterCloneApp
//
//  Created by Paolo Prodossimo Lopes on 06/09/21.
//

import UIKit

class FindUserCell: UITableViewCell {
    
    let userImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.clipsToBounds = true
        image.setDimensions(width: 32, height: 32)
        image.layer.cornerRadius = 32/2
        image.backgroundColor = .twitterBlue
        return image
    }()
    
    let usernameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.text = "Username"
        return label
    }()
    
    private let fullNameUserLabel: UILabel = {
        let label = UILabel()
        label.text = "Name"
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setuLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setuLayout() {
        
        let nameStack = UIStackView(arrangedSubviews: [usernameLabel, fullNameUserLabel])
        nameStack.axis = .vertical
        nameStack.spacing = 3
        nameStack.distribution = .fillProportionally
        
        addSubview(nameStack)
        nameStack.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(userImage)
        
        NSLayoutConstraint.activate([
            userImage.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            userImage.leftAnchor.constraint(equalTo: leftAnchor, constant: 16),
            
            nameStack.topAnchor.constraint(equalTo: userImage.topAnchor),
            nameStack.leftAnchor.constraint(equalTo: userImage.rightAnchor, constant: 5)
        ])
    }
}
