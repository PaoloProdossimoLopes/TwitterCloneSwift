//
//  Components.swift
//  TwitterCloneApp
//
//  Created by Paolo Prodossimo Lopes on 30/05/21.
//

import Foundation
import UIKit

class DontHaveAccountButtonComponent{
    func setButtonDontHaveAccount(_ firstTextPart: String, _ secondTextePart: String) -> UIButton {
        let button = UIButton(type: .system)
        
        let configButtonLabels = NSMutableAttributedString(string: firstTextPart,
                                                           attributes: [NSAttributedString.Key.font:UIFont.systemFont(ofSize: 16),                      NSAttributedString.Key.foregroundColor: UIColor.white])
        
        configButtonLabels.append(NSAttributedString(string: secondTextePart,
                                                     attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 18),                       NSAttributedString.Key.foregroundColor: UIColor.white]))
        button.setAttributedTitle(configButtonLabels, for: .normal)
        
        return button
    }
}
