//
//  MessageCntroller.swift
//  TwitterCloneApp
//
//  Created by Paolo Prodossimo Lopes on 16/05/21.
//

import Foundation
import UIKit
import Firebase

class MessageController: UIViewController {
    
    // MARK: - Properties
    private let logOutButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("LogOut", for: .normal)
        button.tintColor = .systemRed
        
        button.clipsToBounds = true
        button.layer.borderWidth = 3
        button.layer.borderColor = UIColor.systemRed.cgColor
        button.layer.masksToBounds = true
        
        button.addTarget(self, action: #selector(handlerLougOut), for: .touchUpInside)
        
        button.setDimensions(width: 200, height: 50)
        return button
    }()
    
    // MARK: - LifeCicle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    

    // MARK: - Helpers
    func configureUI(){
        navigationItem.title = "Profile"
        view.addSubview(logOutButton)
        logOutButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            logOutButton.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
            logOutButton.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor, constant: 16),
            logOutButton.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor, constant: -16)
        ])
    }
    
    @objc func handlerLougOut() {
        userLoginOut()
    }
    
    private func userLoginOut() {
        do {
            try Auth.auth().signOut()
            goHome()

        } catch let error {
            DEBUGMessage("Ocorreu um erro: \(error.localizedDescription)")
        }
    }
    
    func goHome() {
        DispatchQueue.main.async {
            let viewController = LoginViewController()
            let nav = UINavigationController(rootViewController: viewController)
            nav.modalPresentationStyle = .fullScreen
            self.present(nav, animated: true, completion: nil)
        }
    }
}
