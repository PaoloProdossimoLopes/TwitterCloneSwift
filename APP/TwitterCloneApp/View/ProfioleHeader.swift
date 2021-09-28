//
//  ProfioleHeader.swift
//  TwitterCloneApp
//
//  Created by Paolo Prodossimo Lopes on 04/09/21.
//

import UIKit

protocol ProfileHeaderDelegate: class {
    func handlerDismiss()
}

class ProfileHeader: UICollectionReusableView {
    
    weak var delegate: ProfileHeaderDelegate?
    
    private let filterBar = ProfileFilterView()
    
    let userImage: UIImageView = {
       let img = UIImageView()
        img.widthAnchor.constraint(equalToConstant: 80).isActive = true
        img.heightAnchor.constraint(equalToConstant: 80).isActive = true
        
        img.translatesAutoresizingMaskIntoConstraints = false
        img.clipsToBounds = true
        
        img.layer.cornerRadius = 80/2
        img.layer.borderWidth = 3
        img.layer.borderColor = UIColor.white.cgColor
        img.layer.masksToBounds = true
        
        img.backgroundColor = .twitterBlue
        
       return img
    }()
    
    private let followButton: UIButton = {
        let button = UIButton(type: .system)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        button.widthAnchor.constraint(equalToConstant: 120).isActive = true
        button.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        button.backgroundColor = .white
        button.tintColor = .twitterBlue
        
        button.setTitle("Follow", for: .normal)
        
        button.layer.cornerRadius = 30/2
        button.layer.borderWidth = 1.2
        button.layer.borderColor = UIColor.twitterBlue.cgColor
        
        button.layer.masksToBounds = true
        button.clipsToBounds = true
        
        return button
    }()
    private let bgColorBlue = UIView()
    
    private let backGroundWhiteView = UIView()
    
    lazy var backButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "back_arrow"), for: .normal)
        button.widthAnchor.constraint(equalToConstant: 30).isActive = true
        button.heightAnchor.constraint(equalToConstant: 30).isActive = true
        button.tintColor = .white
        button.addTarget(self, action: #selector(handlerDismiss), for: .touchUpInside)
        
        return button
    }()
    
    private let bioLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.numberOfLines = 3
        label.text = "This is a user bio that will span more thyan one line for test purpose"
        return label
    }()
    
    let fullNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.text = "FullName"
        return label
    }()
    
    let userNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .lightGray
        label.text = "@UserName"
        return label
    }()
    
    let profileFollowersLabel: UILabel = {
        let label = UILabel()
        label.text = "0 Followers"
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .lightGray
        let followTap = UITapGestureRecognizer(target: self, action: #selector(handleFolloersTapped))
        label.addGestureRecognizer(followTap)
        label.isUserInteractionEnabled = true
        return label
    }()
    
    let profileFollowingLabel: UILabel = {
        let label = UILabel()
        label.text = "0 Followings"
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .lightGray
        let followTap = UITapGestureRecognizer(target: self, action: #selector(handleFollowingTapped))
        label.addGestureRecognizer(followTap)
        label.isUserInteractionEnabled = true
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        
        profileFollowersLabel.attributedText = ProfileHeaderModel().followers
        profileFollowingLabel.attributedText = ProfileHeaderModel().following
        
        filterBar.delegate = self
        
        addSubview(bgColorBlue)
        bgColorBlue.translatesAutoresizingMaskIntoConstraints = false
        
        bgColorBlue.anchor(top: self.topAnchor, left: self.leftAnchor, bottom: self.bottomAnchor, right: self.rightAnchor)
        bgColorBlue.addSubview(backGroundWhiteView)
        bgColorBlue.backgroundColor = .twitterBlue
        
        addSubview(userImage)
        addSubview(backButton)
        backButton.translatesAutoresizingMaskIntoConstraints = false
        
        backGroundWhiteView.translatesAutoresizingMaskIntoConstraints = false
        backGroundWhiteView.addSubview(followButton)
        
        backGroundWhiteView.backgroundColor = .white
        
        let stackDetails = UIStackView(arrangedSubviews: [fullNameLabel, userNameLabel, bioLabel])
        stackDetails.axis = .vertical
        stackDetails.spacing = 4
        stackDetails.distribution = .fillProportionally
        
        backGroundWhiteView.addSubview(stackDetails)
        stackDetails.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(filterBar)
        filterBar.translatesAutoresizingMaskIntoConstraints = false
        
        let followStack = UIStackView(arrangedSubviews: [profileFollowersLabel, profileFollowingLabel])
        followStack.axis = .horizontal
        followStack.distribution = .fillEqually
        followStack.spacing = 4
        addSubview(followStack)
        followStack.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            backButton.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 10),
            backButton.leftAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leftAnchor, constant: 20),
            
            userImage.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 50),
            userImage.leftAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leftAnchor, constant: 16),
            
            backGroundWhiteView.topAnchor.constraint(equalTo:  userImage.bottomAnchor, constant: -50),
            backGroundWhiteView.leftAnchor.constraint(equalTo: bgColorBlue.leftAnchor),
            backGroundWhiteView.rightAnchor.constraint(equalTo: bgColorBlue.rightAnchor),
            backGroundWhiteView.bottomAnchor.constraint(equalTo:  bgColorBlue.bottomAnchor),
            
            followButton.topAnchor.constraint(equalTo: backGroundWhiteView.topAnchor, constant: 16),
            followButton.rightAnchor.constraint(equalTo: backGroundWhiteView.rightAnchor, constant: -16),
            
            stackDetails.topAnchor.constraint(equalTo: userImage.bottomAnchor, constant: 10),
            stackDetails.leftAnchor.constraint(equalTo: backGroundWhiteView.leftAnchor, constant: 16),
            stackDetails.rightAnchor.constraint(equalTo: backGroundWhiteView.rightAnchor, constant: -16),
            
            followStack.bottomAnchor.constraint(equalTo: filterBar.topAnchor),
            followStack.leftAnchor.constraint(equalTo: leftAnchor, constant: 16),
            
            filterBar.bottomAnchor.constraint(equalTo: bottomAnchor),
            filterBar.leftAnchor.constraint(equalTo: leftAnchor),
            filterBar.rightAnchor.constraint(equalTo: rightAnchor),
            filterBar.heightAnchor.constraint(equalToConstant: 50)
            
//            followButton.setTitle(viewModel.actionButtonTitle, for: .normal)
        ])
    }

    
    @objc func handlerDismiss() {
        delegate?.handlerDismiss()
    }
    
    @objc func handleFolloersTapped() {
        
    }
    
    @objc func handleFollowingTapped() {
        
    }
    
}

extension ProfileHeader: ProfileFilterViewDelagate {
    func configureAnimationInFilterView(_ view: ProfileFilterView, didSelect indexPath: IndexPath) {
        guard let cell = view.collectionView.cellForItem(at: indexPath) as? ProfileFilterCell else { return }
        let xPosition = cell.frame.origin.x
        UIView.animate(withDuration: 0.3) {
            cell.underlineCell.frame.origin.x = xPosition
        }
    }
}
