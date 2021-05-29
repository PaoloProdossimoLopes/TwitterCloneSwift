//
//  LoginController.swift
//  TwitterCloneApp
//
//  Created by Paolo Prodossimo Lopes on 19/05/21.
//

import Foundation
import UIKit

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
        logo.image = #imageLiteral(resourceName: "twitterLogo")
        logo.tintColor = .black
        
        return logo
    }()
    
    private lazy var emailContentView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        let icon = UIImageView()
        icon.image = #imageLiteral(resourceName: "plus")
        icon.tintColor = .black
        icon.translatesAutoresizingMaskIntoConstraints = false
        icon.heightAnchor.constraint(equalToConstant: 30).isActive = true
        icon.widthAnchor.constraint(equalToConstant: 30).isActive = true
    
        view.addSubview(icon)
        
        return view
    }()
    
    private lazy var passwordContentView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        let icon = UIImageView()
        icon.image = #imageLiteral(resourceName: "home")
        icon.tintColor = .black
        
        
        let textField = UITextField()
        textField.placeholder = "Password"
        textField.textColor = .black
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.heightAnchor.constraint(equalToConstant: 30).isActive = true
        textField.widthAnchor.constraint(equalToConstant: 30).isActive = true
        
        view.addSubview(icon)
        view.addSubview(textField)
        return view
    }()
    
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        configureButton()
       
    }
    
    //MARK: - Selectors
    
    //MARK: - Helpers
    
    private func configureUI(){
        
        view.backgroundColor = .white
        
        navigationController?.navigationBar.isHidden = true
        navigationController?.navigationBar.barStyle = .black // msm nao aprecendo mais deixar as infos em cima mais visiveis
        
        view.addSubview(twitterLogo)
        twitterLogo.heightAnchor.constraint(equalToConstant: 30).isActive = true
        twitterLogo.widthAnchor.constraint(equalToConstant:30).isActive = true
        twitterLogo.translatesAutoresizingMaskIntoConstraints = false
        twitterLogo.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor, constant: 0).isActive = true
//        twitterLogo.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor, constant: 0).isActive = true
        twitterLogo.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        
        let stackView = UIStackView(arrangedSubviews: [emailContentView, passwordContentView])
        stackView.axis = .vertical
        stackView.spacing = 10
        
        view.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.topAnchor.constraint(equalTo: twitterLogo.bottomAnchor, constant: 0).isActive = true
//        stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0).isActive = true
        stackView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 10).isActive = true
        stackView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -10).isActive = true
        
        
    }
    
    
    func configureButton(){
        view.addSubview(goRegisterScreen)
        
    }
    
    
}


extension UIView {
    // adicionei para teste do terminal
    
    func centerX(inView view: UIView, topAnchor: NSLayoutYAxisAnchor? = nil, paddingTop: CGFloat? = 0) {
        translatesAutoresizingMaskIntoConstraints = false
        centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        if let topAnchor = topAnchor {
            self.topAnchor.constraint(equalTo: topAnchor, constant: paddingTop!).isActive = true
        }
    }
}

