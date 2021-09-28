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
    
    func fetchUser(completion: @escaping((User) -> Void)) {
        guard let userID = Auth.auth().currentUser?.uid else { return }
        DEBUGMessage("UserID: \(userID)")
        
        let ref = Database.database().reference().child("users").child(userID).observeSingleEvent(of: .value) { (snapshot) in
            DEBUGMessage("Snapshot: \(snapshot)")
            guard let dictionary = snapshot.value as? [ String : AnyObject ] else { return } // Isso que é responsavel por retoornar convertido em dicionario os dados do usuario salvos no firebase
            DEBUGMessage("Dictionary: dictionary")
            
//            guard let username = dictionary["Username"] as? String else { return }
//            guard let fullname = dictionary["Fullname"] as? String else { return }
//            guard let password = dictionary["Password"] as? String else { return }
//            guard let email = dictionary["Email"] as? String else { return }
//            guard let profileImage = dictionary["Profile-Image"] as? String else { return }
//
//
//            let user = User(fullname: fullname, email: email, username: username, profileImage: profileImage, uid: userID)
//            DEBUGMessage("\(user)")
            
            let user = User(uid: userID, dictionary: dictionary)
            completion(user)
            DEBUGMessage("\(user)")
        }
    }
}
