//
//  ActionSheetViewCell.swift
//  TwitterCloneApp
//
//  Created by Paolo Prodossimo Lopes on 09/09/21.
//

import UIKit

class ActionSheetViewCell: UITableViewCell {
    private let optionImageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.clipsToBounds = true
        image.image = #imageLiteral(resourceName: "twitter_logo_blue")
        return image
    }()
    
    var options: ActionSheetOptions? {
        didSet { configure() }
    }
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18)
        label.text = "Test title"
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUICell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureUICell() {
        addSubview(optionImageView)
        addSubview(titleLabel)
        
        optionImageView.centerY(inView: self)
        optionImageView.anchor(left: leftAnchor, paddingLeft: 8)
        optionImageView.setDimensions(width: 36, height: 36)
        
        titleLabel.centerY(inView: self)
        titleLabel.anchor(left: optionImageView.rightAnchor, paddingLeft: 12)
    }
    
    //MARK: - Helpers
    func configure() {
        titleLabel.text = options?.description
    }
}
