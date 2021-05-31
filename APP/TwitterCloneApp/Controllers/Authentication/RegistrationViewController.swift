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
        view.image = #imageLiteral(resourceName: "plus_photo")
        view.tintColor = .white
        view.contentMode = .scaleAspectFit
        view.setDimensions(width: 120, height: 120)
        return view
    }()
  
    //MARK: - lifeCylcle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    //MARK: - Selctors
    
    
    //MARK: - Helpers
    
    private func configureUI(){
        view.backgroundColor = .white
        
        navigationController?.navigationBar.isHidden = true
        navigationController?.navigationBar.barStyle = .default
        
        view.addSubview(addImageView)
        addImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30).isActive = true
        addImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
    }
}
