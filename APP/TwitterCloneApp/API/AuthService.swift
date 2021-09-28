//
//  File.swift
//  TwitterCloneApp
//
//  Created by Paolo Prodossimo Lopes on 18/07/21.
//

import Foundation
import UIKit
import Firebase

public class AuthCredentials {
    let name: String
    let username: String
    let email: String
    let password: String
    let imageProfile: UIImage
    
    init(name: String, username: String, email: String, password: String, imageProfile: UIImage) {
        self.name = name
        self.username = username
        self.email = email
        self.password = password
        self.imageProfile = imageProfile
    }
}

public struct AuthService {
    static let shered = AuthService()
    
    func userLogin(email: String, password: String, completion: @escaping((AuthDataResult?, Error?) -> Void)) {
        Auth.auth().signIn(withEmail:email, password: password, completion: completion)
    }
    
    func registerUser(_ credentials: AuthCredentials, completion: @escaping ((Error?, DatabaseReference) -> Void)) {
        
        let emailAccount = credentials.email
        let passwordAccount = credentials.password
        let fullname = credentials.name
        let username = credentials.username
        let profileImage = credentials.imageProfile

        guard let imageData = profileImage.jpegData(compressionQuality: 0.3) else { return }
        let imageName = NSUUID().uuidString
        
        DEBUGMessage("Email: \(emailAccount)")
        DEBUGMessage("Password: \(passwordAccount)")
        
        Auth.auth().createUser(withEmail: emailAccount, password: passwordAccount) { (result, error) in
            
            if let error = error {
                DEBUGMessage(error.localizedDescription)
                return
            }
            
            guard let UID = result?.user.uid else { return }
            let ref = Database.database().reference().child("users").child(UID)
            
            let dataStorageRef = Storage.storage().reference()
            let StorageFolder = dataStorageRef.child("profile_image").child(imageName)
            
            StorageFolder.putData(imageData, metadata: nil) { (meta, error) in
                if let error = error {
                    DEBUGMessage(error.localizedDescription)
                }
                DEBUGMessage("Sucesso")
                
                StorageFolder.downloadURL { (url, error) in
                    if let error = error {
                        DEBUGMessage(error.localizedDescription)
                    }
                    
                    guard let profileImageURL = url?.absoluteString else { return }
                    
                    let data: [String : Any] = ["Username": username,
                                                "Fullname": fullname,
                                                "Profile-Image": profileImageURL,
                                                "Email": emailAccount,
                                                "Password": passwordAccount]
                    
                    ref.updateChildValues(data, withCompletionBlock: completion)
                    
//                    ref.updateChildValues(data) { (erorr, reference) in
//
//                        if let error = error {
//                            DEBUGMessage("Error ao salvar os dados na base de dados")
//                            DEBUGMessage(error.localizedDescription)
//                        }
//
//                        DEBUGMessage("Sucesso em salvar os dados")
//                    }
                    
                }
            }
        }
    }
    
    func showAlertPopUpError(fromViewController: UIViewController?, titulo: String, message: String) -> UIAlertController? {
        let alert = UIAlertController()
        alert.title = titulo
        alert.message = message
        
        DEBUGMessage("PopUp de erro Apareceu")
        
        let cancelAction = UIAlertAction(title: "ok", style: .default) { (action) in
            DEBUGMessage("Cliclou em: OK")
            alert.dismiss(animated: true, completion: nil)
        }
        
        alert.addAction(cancelAction)
        
        if fromViewController == nil {
            return alert
        }else {
            fromViewController?.present(alert, animated: true, completion: nil)
            return nil
        }
    }
}

