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
        logo.image = #imageLiteral(resourceName: "twitter_logo_blue")
        logo.tintColor = .black
        
        return logo
    }()

    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
       
    }
    
    //MARK: - Selectors
    
    //MARK: - Helpers
    
    private func configureUI(){
        
        view.backgroundColor = .white
        
        navigationController?.navigationBar.isHidden = true
        //navigationController?.navigationBar.barStyle = .black // msm nao aprecendo mais deixar as infos em cima mais visiveis
        
        view.addSubview(twitterLogo)
        twitterLogo.heightAnchor.constraint(equalToConstant: 70).isActive = true
        twitterLogo.widthAnchor.constraint(equalToConstant: 70).isActive = true
        twitterLogo.translatesAutoresizingMaskIntoConstraints = false
        twitterLogo.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor, constant: 0).isActive = true
//        twitterLogo.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor, constant: 0).isActive = true
        twitterLogo.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
        
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

