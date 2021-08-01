//
//  User.swift
//  TwitterCloneApp
//
//  Created by Paolo Prodossimo Lopes on 01/08/21.
//

import Foundation


struct User {
    let fullname: String
    let email: String
    let username: String
    let profileImage: String
    let uid: String
    
    init(uid: String, dictionary: [String: AnyObject]) {
        self.uid = uid
        
        self.fullname = dictionary["Fullname"] as? String ?? ""
        self.email = dictionary["Email"] as? String ?? ""
        self.username = dictionary["Username"] as? String ?? ""
        self.profileImage = dictionary["Profile-Image"] as? String ?? ""
    }
}
