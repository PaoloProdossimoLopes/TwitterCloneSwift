//
//  ProfileFilterCell.swift
//  TwitterCloneApp
//
//  Created by Paolo Prodossimo Lopes on 06/09/21.
//

import UIKit

class ProfileFilterCell: UICollectionViewCell {
    
    var option: ProfileFilterOptions! {
        didSet { titleLabel.text = option.description }
    }
    
    let titleLabel: UILabel = {
        let label  = UILabel()
        label.textColor = .lightGray
        label.text = "Title"
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    let underlineCell: UIView = {
        let view = UIView()
        view.heightAnchor.constraint(equalToConstant: 2).isActive = true
        view.backgroundColor = .lightGray
        return view
    }()
    
    override var isSelected: Bool {
        didSet{
            let fontSizeForConditon = isSelected ? UIFont.boldSystemFont(ofSize: 16) : UIFont.systemFont(ofSize: 14)
            titleLabel.font = fontSizeForConditon
            titleLabel.textColor = isSelected ? .twitterBlue : .lightGray
            
            underlineCell.backgroundColor = isSelected ? .twitterBlue : .lightGray
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        stupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func stupLayout() {
        addSubview(titleLabel)
        titleLabel.center(inView: self)
        
        addSubview(underlineCell)
        underlineCell.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            underlineCell.bottomAnchor.constraint(equalTo: bottomAnchor),
            underlineCell.leftAnchor.constraint(equalTo: leftAnchor),
            underlineCell.rightAnchor.constraint(equalTo: rightAnchor)
        ])
    
    }
    
}
