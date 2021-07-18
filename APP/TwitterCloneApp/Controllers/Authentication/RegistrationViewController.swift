//
//  RegistrationViewController.swift
//  TwitterCloneApp
//
//  Created by Paolo Prodossimo Lopes on 19/05/21.
//

import Foundation
import UIKit
import Firebase

class RegistrationViewControlelr: UIViewController, UINavigationControllerDelegate {
    
    //MARK: - Properties
    //image
    
    private let imagePicker = UIImagePickerController()
    private var profileImage: UIImage?
    
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
        //         tf.attributedPlaceholder = NSAttributedString(string: "Name", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        tf.attributedPlaceholder = myPlaceholderStyle(text: "Name", Color: .white)
        return tf
    }()
    
    let dividerOne = createDividerInStack()
    
    private let usernameTextField: UITextField = {
        let tf = UITextField()
        tf.font = UIFont.systemFont(ofSize: 16)
        tf.textColor = .white
        //        tf.attributedPlaceholder = NSAttributedString(string: "Lastname", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        tf.attributedPlaceholder = myPlaceholderStyle(text: "Lastname", Color: .white)
        return tf
    }()
    
    let dividerTwo = createDividerInStack()
    
    private let emailTextField: UITextField = {
        let tf = UITextField()
        tf.font = UIFont.systemFont(ofSize: 16)
        tf.textColor = .white
        tf.attributedPlaceholder = NSAttributedString(string: "Username", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        return tf
    }()
    
    let dividerThree = createDividerInStack()
    
    private let passwordTextField: UITextField = {
        let tf = UITextField()
        tf.font = UIFont.systemFont(ofSize: 16)
        tf.textColor = .white
        tf.attributedPlaceholder = NSAttributedString(string: "Password", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        tf.isSecureTextEntry = true
        return tf
    }()
    
    let dividerFour = createDividerInStack()
    
    //Return button
    private lazy var loginButton: UIButton = {
        let button = DontHaveAccountButtonComponent().setButtonDontHaveAccount("Already have a account ", "Login in")
        button.addTarget(self, action: #selector(goLogin), for: .touchUpInside)
        return button
    }()
    
    private lazy var createCountButton: UIButton = {
        let button = UIButton(type: .system)
        //style
        button.setTitle("Sign Up", for: .normal)
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
        DEBUGMessage("Tela de registro carregou")
        configureUI()
    }
    
    //MARK: - Selctors
    @objc func selectYourPhoto() {
        present(imagePicker, animated: true, completion: nil)
    }
    
    @objc func registerHandler() {
        guard let profileImage = profileImage else {
            DEBUGMessage("Por favor selecione uma imagem de perfil ...")
            return
        }
        guard let emailAccount = emailTextField.text else { return }
        guard let passwordAccount = passwordTextField.text else { return }
        guard let fullname = nameTextField.text else { return }
        guard let username = usernameTextField.text else { return }
        
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
                    
                    ref.updateChildValues(data) { (erorr, reference) in
                        
                        if let error = error {
                            DEBUGMessage("Error ao salvar os dados na base de dados")
                            DEBUGMessage(error.localizedDescription)
                        }
                        
                        DEBUGMessage("Sucesso em salvar os dados")
                    }
                    DEBUGMessage("Conta Criada com Sucesso")
                    DEBUGMessage("Acesando o APP ...")
                    let vc = MainTabController()
                    self.navigationController?.pushViewController(vc, animated: true)
                }
            }
        }
        
    }
    
    @objc func goLogin() {
        self.navigationController?.popViewController(animated: true)
        DEBUGMessage("Voltou a tela de Login")
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
        
        let stack = UIStackView(arrangedSubviews: [nameTextField,
                                                   dividerOne,
                                                   usernameTextField,
                                                   dividerTwo,
                                                   emailTextField,
                                                   dividerThree,
                                                   passwordTextField,
                                                   dividerFour,
                                                   createCountButton])
        stack.axis = .vertical
        stack.spacing = 15
        
        view.addSubview(stack)
        stack.anchor(top: ImageButton.bottomAnchor,
                     left: view.leftAnchor,
                     right: view.rightAnchor,
                     paddingTop: 20,
                     paddingLeft: 20,
                     paddingRight: 20)
        
    }
}

//MARK: - UIImage Picker Controller delegate
extension RegistrationViewControlelr: UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        guard let profileImage = info[.editedImage] as? UIImage else { return }
        self.ImageButton.setImage(profileImage.withRenderingMode(.alwaysOriginal), for: .normal)
        self.profileImage = profileImage
        
        self.ImageButton.layer.cornerRadius = ImageButton.frame.height / 2
        self.ImageButton.layer.masksToBounds = true
        self.ImageButton.imageView?.contentMode = .scaleToFill
        self.ImageButton.imageView?.clipsToBounds = true
        self.ImageButton.layer.borderWidth = 3
        self.ImageButton.layer.borderColor = UIColor.white.cgColor
        
        self.dismiss(animated: true, completion: nil)
        
        DEBUGMessage("Imagem adicionada com sucesso ")
        
    }
}

