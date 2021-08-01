//
//  UserService.swift
//  TwitterCloneApp
//
//  Created by Paolo Prodossimo Lopes on 01/08/21.
//

import Foundation
import Firebase

struct UserService {
    static let shared = UserService()
    
    func fetchUser() {
        guard let userID = Auth.auth().currentUser?.uid else { return }
        DEBUGMessage("UserID: \(userID)")
        
        let ref = Database.database().reference().child("users").child(userID).observeSingleEvent(of: .value) { (snapshot) in
            DEBUGMessage("Snapshot: \(snapshot)")
            guard let dictionary = snapshot.value as? [ String : String ] else { return } // Isso que é responsavel por retoornar convertido em dicionario os dados do usuario salvos no firebase
            DEBUGMessage("Dictionary: dictionary")
            
            guard let username = dictionary["Username"] as? String else { return }
            guard let fullname = dictionary["Fullname"] as? String else { return }
            guard let password = dictionary["Password"] as? String else { return }
            guard let email = dictionary["Email"] as? String else { return }
            guard let profileImage = dictionary["Profile-Image"] as? String else { return }
            DEBUGMessage("Username: \(username)")
        }
    }
}
