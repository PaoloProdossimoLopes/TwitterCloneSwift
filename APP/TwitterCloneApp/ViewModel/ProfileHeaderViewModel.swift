//
//  ProfileHeaderViewModel.swift
//  TwitterCloneApp
//
//  Created by Paolo Prodossimo Lopes on 06/09/21.
//

import UIKit

enum ProfileFilterOptions: Int, CaseIterable {
    case tweets = 0
    case replies = 1
    case likes = 2
    
    var description: String {
        switch self {
        case .tweets: return "Tweets"
        case .likes: return "Likes"
        case .replies: return "Tweets & Replies"
        }
    }
}

struct ProfileHeaderModel {
    
    var followers: NSAttributedString? {
        return twoTypesFontInOneLabellet(value: 0, text: "Followers")
    }
    
    var following: NSAttributedString? {
        return twoTypesFontInOneLabellet(value: 0, text: "Following")
    }
    
    fileprivate func twoTypesFontInOneLabellet(value: Int, text: String) -> NSAttributedString {
        let arrayString = NSMutableAttributedString(string: "\(value)", attributes: [.font : UIFont.boldSystemFont(ofSize:16),
                                                                                     .foregroundColor: UIColor.black
                                                                                     ])
        arrayString.append(NSAttributedString(string: " \(text)", attributes: [.font: UIFont.systemFont(ofSize: 14),
                                                                               .foregroundColor: UIColor.lightGray]))
        return arrayString
    }
    
}
