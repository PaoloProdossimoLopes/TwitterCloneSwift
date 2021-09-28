//
//  TweetHeader.swift
//  TwitterCloneApp
//
//  Created by Paolo Prodossimo Lopes on 06/09/21.
//

import UIKit

protocol TweetHeaderDelegate: class {
    func handleActionSheet()
}

class TweetHeader: UICollectionReusableView {
    //MARK: - Properties
    var name: String = "UserName"
    
    weak var delegate: TweetHeaderDelegate?
    
    let userImage: UIImageView = {
        let image = UIImageView()
        image.backgroundColor = .twitterBlue
        image.clipsToBounds = true
        image.setDimensions(width: 50, height: 50)
        image.layer.cornerRadius = 50/2
        image.layer.masksToBounds = true
        image.layer.borderColor = UIColor.white.cgColor
        image.layer.borderWidth = 3
        return image
    }()
    
    let username: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.text = "@" + "Username"
        return label
    }()
    
    let fullNameUser: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.text = "Full name"
        return label
    }()
    
    let captionArea: UILabel = {
        let caption = UILabel()
        caption.text = "Some caaptions here ..."
        caption.font = UIFont.systemFont(ofSize: 18)
        caption.numberOfLines = 3
        return caption
    }()
    
    let buttonsInteractions = InteractionsButtonView()
    
    let downButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "down_arrow_24pt"), for: .normal)
        button.tintColor = .systemGray
        button.setDimensions(width: 50, height: 50)
        button.addTarget(self, action: #selector(optionButtonDown), for: .touchUpInside)
        return button
    }()
    
    
    //MARK: - LifeCycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func optionButtonDown() {
        delegate?.handleActionSheet()
    }
    
    func configureView() {
        addSubview(userImage)
        userImage.translatesAutoresizingMaskIntoConstraints = false
        
        let nameStack = UIStackView(arrangedSubviews: [username, fullNameUser])
        addSubview(nameStack)
        nameStack.translatesAutoresizingMaskIntoConstraints = false
        nameStack.distribution = .fillProportionally
        nameStack.spacing = 4
        nameStack.axis = .vertical
        
        addSubview(downButton)
        downButton.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(captionArea)
        captionArea.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(buttonsInteractions)
        buttonsInteractions.translatesAutoresizingMaskIntoConstraints = false
        
//        captionArea.text = lorenIpsumForTextTest///
        
        NSLayoutConstraint.activate([
            userImage.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            userImage.leftAnchor.constraint(equalTo: leftAnchor, constant: 16),
            
            nameStack.topAnchor.constraint(equalTo: userImage.topAnchor),
            nameStack.leftAnchor.constraint(equalTo: userImage.rightAnchor, constant: 10),
            
            downButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -16),
            downButton.topAnchor.constraint(equalTo: username.topAnchor),
            
            captionArea.topAnchor.constraint(equalTo: userImage.bottomAnchor, constant: 10),
            captionArea.leftAnchor.constraint(equalTo: leftAnchor, constant: 16),
            captionArea.rightAnchor.constraint(equalTo: rightAnchor, constant: -16),
            
            buttonsInteractions.topAnchor.constraint(equalTo: captionArea.bottomAnchor, constant: 10),
            buttonsInteractions.leftAnchor.constraint(equalTo: leftAnchor, constant: 16),
            buttonsInteractions.rightAnchor.constraint(equalTo: rightAnchor, constant: -16),
        ])
    }
}



