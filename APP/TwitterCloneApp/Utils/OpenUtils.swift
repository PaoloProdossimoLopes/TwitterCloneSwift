//
//  OpenUtils.swift
//  TwitterCloneApp
//
//  Created by Paolo Prodossimo Lopes on 18/07/21.
//

import Foundation
import UIKit

public func DEBUGMessage(_ message: String) {
    print("---")
    print("DEBUG: \(message)")
    print("---")
}

public func myPlaceholderStyle(text: String, Color: UIColor) -> NSAttributedString {
    let myCustomPlaceholder = NSAttributedString(string: text, attributes: [NSAttributedString.Key.foregroundColor: Color])
    return myCustomPlaceholder
}

