//
//  MainTabController.swift
//  TwitterCloneApp
//
//  Created by Paolo Prodossimo Lopes on 16/05/21.
//

import UIKit
import Firebase

class MainTabController: UITabBarController {
    
    let buttonAction:  UIButton = {
        
        let button = UIButton(type: .system)
        button.backgroundColor = .systemBlue
        button.tintColor = .white
        
        button.setImage(UIImage(named: "new_tweet"), for: .normal)
        
        //responsavel por capturar a açao do botao
        button.addTarget(self, action: #selector(TouchActionButton), for: .touchUpInside)
        //note que #selector pede para adicionar um objCMethod, ou seja um funçao criada separadamente com o metodod "@objc func nomeDaFunçao(){}"

        return button
    }()
    
    
    // MARK: - LifeCicle

    override func viewDidLoad() {
        super.viewDidLoad()
        userLoginOut() //Desfaz o login no autehticator ...
        view.backgroundColor = .twitterBlue
        AutehticationUSerAndConfigureUI()
        DEBUGMessage("MainTabController Carregou ...")
    }
    
    //MARK: - API
    func AutehticationUSerAndConfigureUI() {
        if Auth.auth().currentUser == nil {
            DispatchQueue.main.async {
                let viewController = LoginViewController()
                let nav = UINavigationController(rootViewController: viewController)
                nav.modalPresentationStyle = .fullScreen
                self.present(nav, animated: true, completion: nil)
            }
        } else {
            configureViewControllers()
            setupStyleNavigationBar()
            configureUIButtonAction()
            
        }
    }
    
    private func userLoginOut() {
        do {
            try Auth.auth().signOut()
        } catch let error {
            DEBUGMessage("Ocorreu um erro: \(error.localizedDescription)")
        }
    }

}


extension MainTabController{
    
    // MARK: - Properties

    //MARK: - Selectors
    @objc func TouchActionButton(){
        print("Toquei no botao de Criar um novo post")
    }

    // MARK: - Helpers
    
    func configureUIButtonAction(){
        view.addSubview(buttonAction)
        navigationController?.navigationBar.isHidden = true
//        let buttonSize = 10
        
        buttonAction.contentMode = .scaleAspectFit
        
        buttonAction.translatesAutoresizingMaskIntoConstraints = false
        
        buttonAction.heightAnchor.constraint(equalToConstant: CGFloat(65)).isActive = true
        buttonAction.widthAnchor.constraint(equalToConstant: CGFloat(65)).isActive = true
        
        buttonAction.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -70).isActive = true
        buttonAction.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -25).isActive = true
        
        buttonAction.layer.cornerRadius = CGFloat(65/2)
    }
    
    func configureViewControllers(){
        
        //Instanciando e custostomizando as controllers
        let feed = FeedController()
        //feed.tabBarItem.image = UIImage(named: "feed")
        let feedNav = templateNavigationCOntroller(MyImageName: "home", MyViewController: feed, NavigationBar: false)
        
        
        let explore = ExploreController()
//        explore.tabBarItem.image = UIImage(named: "explore")
        let exploreNav = templateNavigationCOntroller(MyImageName: "search", MyViewController: explore, NavigationBar: false)
        
        
        let notification = NotificationController()
//        notification.tabBarItem.image = UIImage(named: "notification")
        let notificationNav = templateNavigationCOntroller(MyImageName: "comment", MyViewController: notification, NavigationBar: false)
        
        
        let message = MessageController()
//        message.tabBarItem.image = UIImage(named: "message")
        let messageNav = templateNavigationCOntroller(MyImageName: "perfil", MyViewController: message, NavigationBar: false)
        
        
        //palavra reservada para a tabBar setar quais view exibir nela para navegar
        viewControllers = [feedNav, exploreNav, notificationNav, messageNav]
        
    }
    
    
    func templateNavigationCOntroller(MyImageName: String, MyViewController: UIViewController, NavigationBar: Bool) -> UINavigationController{
        
        //Vinculando uma Viewcontroller para criar uma NavigationBar
        let nav = UINavigationController(rootViewController: MyViewController)
        //CUstomizando a TabBar
        let images = UIImage(named: MyImageName)
        nav.tabBarItem.image = images
        nav.tabBarController?.tabBar.backgroundColor = .white
        //Customizando a NavigationBar
        nav.navigationBar.backgroundColor = .white
        nav.setNavigationBarHidden(NavigationBar, animated: !NavigationBar)
        nav.navigationBar.isHidden = NavigationBar
        return nav
    }
    
    
    func setupStyleNavigationBar(){
        //Deixando a ViewBranca
        view.backgroundColor = .white
        //Deixando a TabBar Branca
        tabBar.barTintColor = .white
        //Itens Selecionandos na tabBar ficam na cor azul Claro
        tabBar.tintColor = .systemBlue
    }
}
