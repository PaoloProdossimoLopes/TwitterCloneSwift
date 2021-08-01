//
//  OpenUtils.swift
//  TwitterCloneApp
//
//  Created by Paolo Prodossimo Lopes on 18/07/21.
//

import Foundation
import UIKit

public func DEBUGMessage(_ myMessage: String?) {
    guard let message = myMessage else { return }
    
    print("\n---")
    print("📥 DEBUG: \(message)")
    print("---\n")
}

public func myPlaceholderStyle(text: String, Color: UIColor) -> NSAttributedString {
    let myCustomPlaceholder = NSAttributedString(string: text, attributes: [NSAttributedString.Key.foregroundColor: Color])
    return myCustomPlaceholder
}

func createDividerInStack() -> UIView {
    let view = UIView()
    
    view.translatesAutoresizingMaskIntoConstraints = false
    view.backgroundColor = .white
    
    NSLayoutConstraint.activate([
        view.heightAnchor.constraint(equalToConstant: 1)
    ])
    
    return view
}
