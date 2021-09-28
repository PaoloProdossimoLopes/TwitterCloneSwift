//
//  actionsButtons.swift
//  TwitterCloneApp
//
//  Created by Paolo Prodossimo Lopes on 06/09/21.
//

import UIKit

class InteractionsButtonView: UIView {
    
    private let likeButton: UIButton = {
        let bnt = UIButton(type: .system)
        bnt.tintColor = .darkGray
        bnt.setDimensions(width: 20, height: 20)
        bnt.setImage(UIImage(named: "like"), for: .normal)
        return bnt
    }()
    
    private let comentButton: UIButton = {
        let bnt = UIButton(type: .system)
        bnt.tintColor = .darkGray
        bnt.setDimensions(width: 20, height: 20)
        bnt.setImage(UIImage(named: "comment"), for: .normal)
        return bnt
    }()
    
    private let shareButton: UIButton = {
        let bnt = UIButton(type: .system)
        bnt.tintColor = .darkGray
        bnt.setDimensions(width: 20, height: 20)
        bnt.setImage(UIImage(named: "share"), for: .normal)
        return bnt
    }()
    
    private let retweetButton: UIButton = {
        let bnt = UIButton(type: .system)
        bnt.tintColor = .darkGray
        bnt.setDimensions(width: 20, height: 20)
        bnt.setImage(UIImage(named: "retweet"), for: .normal)
        return bnt
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureView() {
        let stackButton = UIStackView(arrangedSubviews: [likeButton, shareButton, comentButton, retweetButton])
        stackButton.translatesAutoresizingMaskIntoConstraints = false
        stackButton.axis = .horizontal
        stackButton.distribution = .fillEqually
        stackButton.spacing = 4
        addSubview(stackButton)
        
        stackButton.topAnchor.constraint(equalTo: topAnchor).isActive = true
        stackButton.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        stackButton.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
    }
}
