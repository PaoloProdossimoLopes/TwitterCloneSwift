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

public let lorenIpsumForTextTest: String = """
String = Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum
"""

func size(_ text: String, forWidth width: CGFloat) -> CGSize {
    let measureLabel = UILabel()
    measureLabel.text = text
    measureLabel.numberOfLines = 0
    measureLabel.lineBreakMode = .byWordWrapping
    measureLabel.translatesAutoresizingMaskIntoConstraints = false
    measureLabel.widthAnchor.constraint(equalToConstant: width).isActive = true
    return measureLabel.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
}
