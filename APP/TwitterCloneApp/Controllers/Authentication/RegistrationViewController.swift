//
//  RegistrationViewController.swift
//  TwitterCloneApp
//
//  Created by Paolo Prodossimo Lopes on 19/05/21.
//

import Foundation
import UIKit

class RegistrationViewControlelr: UIViewController, UINavigationControllerDelegate {
    
    //MARK: - Properties
    //image
    
    private let imagePicker = UIImagePickerController()
    
    private let ImageButton: UIButton = {
        let image = #imageLiteral(resourceName: "perfil")
        
        let button = UIButton(type: .system)
        button.setImage(image, for: .normal)
        button.tintColor = .white
        button.addTarget(self, action: #selector(selectYourPhoto), for: .touchUpInside)
        
        return button
    }()
    
    //Text field
    private let nameTextField: UITextField = {
         let tf = UITextField()
         tf.font = UIFont.systemFont(ofSize: 16)
         tf.textColor = .white
         tf.attributedPlaceholder = NSAttributedString(string: "Name", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
         return tf
    }()
    
    private let lastNameTextField: UITextField = {
        let tf = UITextField()
        tf.font = UIFont.systemFont(ofSize: 16)
        tf.textColor = .white
        tf.attributedPlaceholder = NSAttributedString(string: "Lastname", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        return tf
    }()
    
    private let emailTextField: UITextField = {
        let tf = UITextField()
        tf.font = UIFont.systemFont(ofSize: 16)
        tf.textColor = .white
        tf.attributedPlaceholder = NSAttributedString(string: "Username", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        return tf
    }()
    
    private let passwordTextField: UITextField = {
        let tf = UITextField()
        tf.font = UIFont.systemFont(ofSize: 16)
        tf.textColor = .white
        tf.attributedPlaceholder = NSAttributedString(string: "Password", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        tf.isSecureTextEntry = true
        return tf
    }()
    
    //Return button
    private lazy var loginButton: UIButton = {
        let button = DontHaveAccountButtonComponent().setButtonDontHaveAccount("Already have a account ", "Login in")
        button.addTarget(self, action: #selector(goLogin), for: .touchUpInside)
        return button
    }()
    
    private lazy var createCountButton: UIButton = {
        let button = UIButton(type: .system)
        //style
        button.setTitle("Sign in", for: .normal)
        button.tintColor = .twitterBlue
        button.backgroundColor = .white
        
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        button.layer.cornerRadius = 5
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        
        button.addTarget(self, action: #selector(registerHandler), for: .touchUpInside)
        
        return button
    }()
    
    //MARK: - lifeCylcle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    //MARK: - Selctors
    @objc func selectYourPhoto() {
        present(imagePicker, animated: true, completion: nil)
    }
    
    @objc func registerHandler() {
        let vc = MainTabController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func goLogin() {
        self.navigationController?.popViewController(animated: true)
    }
    
    //MARK: - Helpers
    
    private func configureUI(){
        view.backgroundColor = .twitterBlue
        
        navigationController?.navigationBar.isHidden = true
        navigationController?.navigationBar.barStyle = .default
        
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        
        view.addSubview(ImageButton)
        ImageButton.heightAnchor.constraint(equalToConstant: 150).isActive = true
        ImageButton.widthAnchor.constraint(equalToConstant: 150).isActive = true
        ImageButton.translatesAutoresizingMaskIntoConstraints = false
        ImageButton.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor, constant: 0).isActive = true
        ImageButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
        ImageButton.imageView?.contentMode = .scaleToFill
        ImageButton.layer.cornerRadius = (ImageButton.frame.height / 2)
        ImageButton.clipsToBounds = true
        ImageButton.layer.borderColor = UIColor.white.cgColor
        ImageButton.layer.borderWidth = 3
        
        view.addSubview(loginButton)
        loginButton.anchor(left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingLeft: 10, paddingBottom: 30, paddingRight: 10)
        
        let stack = UIStackView(arrangedSubviews: [nameTextField, lastNameTextField, emailTextField, passwordTextField, createCountButton])
        stack.axis = .vertical
        stack.spacing = 20
        
        view.addSubview(stack)
        stack.anchor(top: ImageButton.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 20, paddingLeft: 20, paddingRight: 20)

    }
}

//MARK: - UIImage Picker Controller delegate
extension RegistrationViewControlelr: UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        guard let profileImage = info[.editedImage] as? UIImage else { return }
        self.ImageButton.setImage(profileImage.withRenderingMode(.alwaysOriginal), for: .normal)
        
        self.ImageButton.layer.cornerRadius = ImageButton.frame.height / 2
        self.ImageButton.layer.masksToBounds = true
        self.ImageButton.imageView?.contentMode = .scaleToFill
        self.ImageButton.imageView?.clipsToBounds = true
        self.ImageButton.layer.borderWidth = 3
        self.ImageButton.layer.borderColor = UIColor.white.cgColor
        
        self.dismiss(animated: true, completion: nil)
    }
}

