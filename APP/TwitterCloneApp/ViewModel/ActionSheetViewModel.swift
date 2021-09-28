//
//  ActionSheetViewModel.swift
//  TwitterCloneApp
//
//  Created by Paolo Prodossimo Lopes on 09/09/21.
//

import Foundation

enum ActionSheetOptions {
    case follow(String)
    case unfollow(String)
    case report
    case delete
    
    var description: String {
        switch self {
        case .follow(let user):
            return "follow is @\(user)"
        case .unfollow(let user):
            return "Unfollow is @\(user)"
        case .report:
            return "report tweet"
        case .delete:
            return "delete tweet"
        }
    }
}

struct ActionSheetViewModel {
    
    private let user: String
    
    var options: [ActionSheetOptions] {
        var results = [ActionSheetOptions]()
        results.append(.follow("You"))
        results.append(.delete)
        results.append(.report)
        
        return results
    }
    
    init(user: String) {
        self.user = user
    }
    
}
