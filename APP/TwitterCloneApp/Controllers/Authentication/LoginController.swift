//
//  LoginController.swift
//  TwitterCloneApp
//
//  Created by Paolo Prodossimo Lopes on 19/05/21.
//

import Foundation
import UIKit
import Firebase

class LoginViewController: UIViewController {
    //MARK: - Properties
    
    var goRegisterScreen:UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Sing up", for: .normal)
        return button
    }()
    
    var twitterLogo : UIImageView = {
        let logo = UIImageView()
        logo.contentMode = .scaleAspectFit
        logo.clipsToBounds = true
        logo.image = #imageLiteral(resourceName: "TwitterLogo")
        return logo
    }()
    
    private lazy var emailContainerView: UIView = {
        let view = UIView()
        view.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        let icon = UIImageView()
        icon.image = #imageLiteral(resourceName: "mail")
        icon.tintColor = .white
        view.addSubview(icon)

        icon.anchor(left: view.leftAnchor, bottom: view.bottomAnchor, paddingLeft: 8, paddingBottom: 8)
        icon.setDimensions(width: 24, height: 24)
        
        view.addSubview(emailTexteField)
        emailTexteField.anchor(left: icon.rightAnchor, bottom:view.bottomAnchor, right:view.rightAnchor, paddingLeft:8, paddingBottom: 8 , paddingRight:8)
        
        let dividerView = UIView()
        dividerView.backgroundColor = .white
        view.addSubview(dividerView)
        dividerView.anchor(left: view.leftAnchor, bottom: view.bottomAnchor,right: view.rightAnchor, paddingLeft: 8, paddingRight: 8, height: 1.0)
        
        return view
    }()
    
    private lazy var passwordContainerView: UIView = {
        let view = UIView()
        view.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        let icon = UIImageView()
        icon.image = #imageLiteral(resourceName: "ic_lock_outline_white_2x")
        icon.tintColor = .white
        view.addSubview(icon)

        icon.anchor(left: view.leftAnchor, bottom: view.bottomAnchor, paddingLeft: 8, paddingBottom: 8)
        icon.setDimensions(width: 24, height: 24)
        
        view.addSubview(passwordTextField)
        passwordTextField.anchor(left: icon.rightAnchor, bottom:view.bottomAnchor, right:view.rightAnchor, paddingLeft:8,paddingBottom: 8 ,paddingRight:8)
        
        let dividerView = UIView()
        dividerView.backgroundColor = .white
        view.addSubview(dividerView)
        dividerView.anchor(left: view.leftAnchor, bottom: view.bottomAnchor,right: view.rightAnchor, paddingLeft: 8, paddingRight: 8, height: 1.0)
        
        return view
    }()
    
    private lazy var emailTexteField: UITextField = {
       let tf = UITextField()
//        tf.placeholder = "E-mail"
        tf.textColor = .white
        tf.font = UIFont.systemFont(ofSize: 16)
        tf.attributedPlaceholder = NSAttributedString(string: "E-mail" , attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
       return tf
    }()
    
    private lazy var passwordTextField: UITextField = {
       let tf = UITextField()
//        tf.placeholder = "Password"
        tf.font = UIFont.systemFont(ofSize: 16)
        tf.textColor = .white
        tf.attributedPlaceholder = NSAttributedString(string: "Password", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        tf.isSecureTextEntry = true
        return tf
    }()
    
    private lazy var loginButton: UIButton = {
        let button = UIButton(type: .system)
        //style
        button.setTitle("Sign in", for: .normal)
        button.tintColor = .twitterBlue
        button.backgroundColor = .white
        
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        button.layer.cornerRadius = 5
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        
        button.addTarget(self, action: #selector(LoginAccept), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var DontHaveAccountButton : UIButton = {
        let button = DontHaveAccountButtonComponent().setButtonDontHaveAccount("if you don't have account: ","register")
        
        button.addTarget(self, action: #selector(signUp), for: .touchUpInside)
        
        return button
    }()
    

    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        DEBUGMessage("Tela de login carregou")
        configureUI()
       
    }
    
    //MARK: - Selectors
    @objc private func signUp() {
        DEBUGMessage("Cliclou no botao de ir para tela de registro")
        let view = RegistrationViewControlelr()
        navigationController?.pushViewController(view, animated: true)
    }
    
    @objc private func LoginAccept() {
        
        guard let email = emailTexteField.text else { return }
        guard let password = passwordTextField.text else { return }
        
        DEBUGMessage("Email: \(email)")
        DEBUGMessage("Senha: \(password)")
        
        let view = MainTabController()
        navigationController?.pushViewController(view, animated: true)
    }
    
    //MARK: - Helpers
    
    private func configureUI(){
        
        navigationController?.navigationBar.isHidden = true
        navigationController?.navigationBar.barStyle = .black

        
        view.addSubview(twitterLogo)
        twitterLogo.heightAnchor.constraint(equalToConstant: 150).isActive = true
        twitterLogo.widthAnchor.constraint(equalToConstant: 150).isActive = true
        twitterLogo.translatesAutoresizingMaskIntoConstraints = false
        twitterLogo.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor, constant: 0).isActive = true
//        twitterLogo.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor, constant: 0).isActive = true
        twitterLogo.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
        
        view.backgroundColor = .twitterBlue
        
        let stack = UIStackView(arrangedSubviews: [emailContainerView, passwordContainerView, loginButton])
        stack.axis = .vertical
        stack.spacing = 10
        
        view.addSubview(stack)
        stack.anchor(top: twitterLogo.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingLeft: 10,paddingRight: 10)
        
        view.addSubview(DontHaveAccountButton)
        DontHaveAccountButton.anchor(left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingLeft: 8, paddingBottom: 40, paddingRight: 8)
        
    }
}

