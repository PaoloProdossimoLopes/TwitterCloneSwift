//
//  TweetCell.swift
//  TwitterCloneApp
//
//  Created by Paolo Prodossimo Lopes on 19/08/21.
//

import UIKit

protocol TweetCellDeleagte: class {
    func handlerOpenProfilleController()
    func handleReplyTweet(_ cell: TweetCell )
    func handleLikeTweet(_ cell: TweetCell)
}

class TweetCell: UICollectionViewCell {
    weak var delegate: TweetCellDeleagte?
    
    var tweet: Tweets?
    
    //MARK: - Properties
    lazy var profileImage: UIImageView = {
       let img = UIImageView()
        img.contentMode = .scaleAspectFit
        img.clipsToBounds = true
        img.setDimensions(width: 48, height: 48)
        img.layer.cornerRadius = 48/2
        img.backgroundColor = .twitterBlue
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(handlerOpenProfilleController))
        img.addGestureRecognizer(tap)
        img.isUserInteractionEnabled = true
        
        return img
    }()
    
    let captionLAbel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.text = "Some test caption"
        label.numberOfLines = 0
        return label
    }()
    private let userName = UILabel()
    private let info = UILabel()
    
    private let likeButton: UIButton = {
        let bnt = UIButton(type: .system)
        bnt.tintColor = .darkGray
        bnt.setDimensions(width: 20, height: 20)
        bnt.setImage(UIImage(named: "like"), for: .normal)
        bnt.addTarget(self, action: #selector(handleLikeButton), for: .touchUpInside)
        return bnt
    }()
    
    private let comentButton: UIButton = {
        let bnt = UIButton(type: .system)
        bnt.tintColor = .darkGray
        bnt.setDimensions(width: 20, height: 20)
        bnt.setImage(UIImage(named: "comment"), for: .normal)
        bnt.addTarget(self, action: #selector(handleComentButton), for: .touchUpInside)
        return bnt
    }()
    
    private let shareButton: UIButton = {
        let bnt = UIButton(type: .system)
        bnt.tintColor = .darkGray
        bnt.setDimensions(width: 20, height: 20)
        bnt.setImage(UIImage(named: "share"), for: .normal)
        bnt.addTarget(self, action: #selector(handleShareButton), for: .touchUpInside)
        return bnt
    }()
    
    private let retweetButton: UIButton = {
        let bnt = UIButton(type: .system)
        bnt.tintColor = .darkGray
        bnt.setDimensions(width: 20, height: 20)
        bnt.setImage(UIImage(named: "retweet"), for: .normal)
        bnt.addTarget(self, action: #selector(handleRetweetButton), for: .touchUpInside)
        return bnt
    }()
    
    //MARK: - LifeCycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
        
        addSubview(profileImage)
        
        userName.text = "Eddie Brock"
        userName.font = UIFont.boldSystemFont(ofSize: 16)
        
        info.text = "@Venon - 3s"
        info.textColor = .gray
        info.font = UIFont.systemFont(ofSize: 12)
        
        let namePlusInfoStack = UIStackView(arrangedSubviews: [userName, info])
        namePlusInfoStack.axis = .horizontal
        namePlusInfoStack.distribution = .fillProportionally
        namePlusInfoStack.spacing = 10
        namePlusInfoStack.alignment = .center
        
        let stack = UIStackView(arrangedSubviews: [namePlusInfoStack, captionLAbel ])
        stack.axis = .vertical
        stack.spacing = 4
        stack.distribution = .fillProportionally
        stack.translatesAutoresizingMaskIntoConstraints = false
        addSubview(stack)
        
        let undelineView = UIView()
        undelineView.backgroundColor = .systemGroupedBackground
        undelineView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(undelineView)
        
        let actionStack = UIStackView(arrangedSubviews: [likeButton, comentButton, retweetButton, shareButton])
        actionStack.axis = .horizontal
        actionStack.spacing = 72
        actionStack.distribution = .fillEqually
        actionStack.translatesAutoresizingMaskIntoConstraints = false
        addSubview(actionStack)

        profileImage.topAnchor.constraint(equalTo: topAnchor, constant: 12).isActive = true
        profileImage.leftAnchor.constraint(equalTo: leftAnchor, constant: 8).isActive = true

        stack.topAnchor.constraint(equalTo: profileImage.topAnchor).isActive = true
        stack.leftAnchor.constraint(equalTo: profileImage.rightAnchor, constant: 5).isActive = true
//        stack.rightAnchor.constraint(equalTo: rightAnchor, constant: -8).isActive = true
        
        actionStack.topAnchor.constraint(equalTo: undelineView.topAnchor, constant: -(25)).isActive = true
        actionStack.leftAnchor.constraint(equalTo: leftAnchor, constant: 8).isActive = true
        actionStack.rightAnchor.constraint(equalTo: rightAnchor, constant: -8).isActive = true

        undelineView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        undelineView.leftAnchor.constraint(equalTo: leftAnchor, constant: 8).isActive = true
        undelineView.rightAnchor.constraint(equalTo: rightAnchor, constant: -8).isActive = true
        undelineView.heightAnchor.constraint(equalToConstant: 2).isActive = true
        
    }
    
    func changeLikeImage() {
        guard let isLiked = tweet?.didLike else { return }
        if isLiked {
            likeButton.tintColor = .red
        } else {
            likeButton.tintColor = .darkGray
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Selectors
    
    @objc func handlerOpenProfilleController() {
        DEBUGMessage("Clicou na imagem, estou no arquivo da cell")
        delegate?.handlerOpenProfilleController()
    }
    
    @objc func handleLikeButton() {
        delegate?.handleLikeTweet(self)
    }
    
    @objc func handleComentButton() {
        delegate?.handleReplyTweet(self)
    }
    
    @objc func handleRetweetButton() {
        
    }
    
    @objc func handleShareButton() {
        
    }
    
    //MARK: - Helpers
}
