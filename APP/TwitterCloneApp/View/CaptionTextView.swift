//
//  CaptionTextView.swift
//  TwitterCloneApp
//
//  Created by Paolo Prodossimo Lopes on 19/08/21.
//

import UIKit

class CaptionTextView: UITextView {
    
    //MARK: - Properties
    let placeHolderLabel: UILabel = {
        let label = UILabel()
        label.textColor = .darkGray
        label.text = "What's Happening?"
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()
    
    //MARK: - LifeCycle
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        setupLayoutCaptionTextView()
        setupLayoutPlaceHolderLabel()
        setPlaceHolderLabelObserver()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Setup Helpers
    fileprivate func setupLayoutCaptionTextView() {
        backgroundColor = super.backgroundColor
        font = UIFont.boldSystemFont(ofSize: 16)
        heightAnchor.constraint(equalToConstant: 300).isActive = true
        isScrollEnabled = false
    }
    
    fileprivate func setupLayoutPlaceHolderLabel() {
        addSubview(placeHolderLabel)
        placeHolderLabel.translatesAutoresizingMaskIntoConstraints = false
        placeHolderLabel.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        placeHolderLabel.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        placeHolderLabel.topAnchor.constraint(equalTo: topAnchor).isActive = true
    }
    
    //MARK: - Observers
    
    fileprivate func setPlaceHolderLabelObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(handleTextChange), name: UITextView.textDidChangeNotification, object: nil)
    }
    
    //MARK: - Selctors
    @objc func handleTextChange() {
        //Esconde o placeHolder quando a UIText nao for vazia
        placeHolderLabel.isHidden = !text.isEmpty
    }
}
