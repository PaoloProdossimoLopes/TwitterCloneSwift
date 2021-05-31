//
//  RegistrationViewController.swift
//  TwitterCloneApp
//
//  Created by Paolo Prodossimo Lopes on 19/05/21.
//

import Foundation
import UIKit

class RegistrationViewControlelr: UIViewController {
    
    //MARK: - Properties
    
    private lazy var addImageView: UIImageView = {
        let view = UIImageView()
//        view.backgroundColor = .white
        view.image = #imageLiteral(resourceName: "perfil")
        view.contentMode = .scaleAspectFit
        view.setDimensions(width: 120, height: 120)
        return view
    }()
    
    private lazy var loginLabel: UIButton = {
        let button = DontHaveAccountButtonComponent().setButtonDontHaveAccount("Already have a account ", "Login in")
        button.addTarget(self, action: #selector(goLogin), for: .touchUpInside)
        return button
    }()
    
    //MARK: - lifeCylcle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    //MARK: - Selctors
    @objc private func goLogin() {
        _ = LoginViewController()
        navigationController?.popViewController(animated: true)
    }
    
    //MARK: - Helpers
    
    private func configureUI(){
        view.backgroundColor = .twitterBlue
        
        navigationController?.navigationBar.isHidden = true
        navigationController?.navigationBar.barStyle = .default
        
        view.addSubview(addImageView)
        addImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30).isActive = true
        addImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        
        view.addSubview(loginLabel)
        loginLabel.anchor(left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingLeft: 10, paddingBottom: 30, paddingRight: 10)
    }
}
