//
//  UploadTweetControllerViewController.swift
//  TwitterCloneApp
//
//  Created by Paolo Prodossimo Lopes on 01/08/21.
//

import UIKit
import SDWebImage

enum UploadTweetConfiguration {
    case tweet
    case replie(Tweets)
}

class UploadTweetControllerViewController: UIViewController {
    
    //MARK: - Properties
    
    var user: User? {
        didSet {
            createUserImageInTwitter()
        }
    }
    
    private let config: UploadTweetConfiguration
    
    private let UserImage: UIImageView = {
        let image = UIImageView()
        image.setDimensions(width: 42, height: 42)
        image.layer.cornerRadius = 42 / 2
        image.layer.masksToBounds = true
        return image
    }()
    
    private var newTweetButton: UIButton = {
        let button = UIButton(type: .system)
        
        button.backgroundColor = .twitterBlue
        button.setTitle("Tweet", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.textAlignment = .center
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        
        button.frame = CGRect(x: 0, y: 0, width: 64, height: 32)
        button.layer.cornerRadius = 32 / 2
        button.layer.masksToBounds = true
        
//        button.addTarget(self, action: #selector(handleNewTweet), for: .touchUpInside)
        
        return button
    }()
    
    private let textLabel = CaptionTextView()
    
    init(config: UploadTweetConfiguration) {
        self.config = config
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
    }
    
    //MARK: - Selectors
    
    @objc func handleCancel() { self.dismiss(animated: true, completion: nil) }
    
    @objc func handleNewTweet() {
        //tweetAction
        guard let caption = textLabel.text else { return }
        
        TweetService.shared.uploadTweet(caption: caption) { (ref, error) in
            if error == nil{
                self.presentAlert()
            } else {
                
            }
        }
        //close
        handleCancel()
    }
    
    //MARK: - API
    
    //MARK: - Helpers
    
    func presentAlert() {
        let alert = UIAlertController(title: "Did you bring your towel?", message: "It's recommended you bring your towel before continuing.", preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: nil))
        alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))
        
        self.navigationController?.pushViewController(alert, animated: true)
    }
    
    func setupLayout() {
        self.view.backgroundColor = .white
        self.navigationController?.navigationBar.barTintColor = .white
        self.navigationController?.navigationBar.isTranslucent = false
        self.title = "Add Tweet"
        
        let buttonCancel = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(handleCancel))
        self.navigationItem.leftBarButtonItem = buttonCancel
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: newTweetButton)
        self.newTweetButton.addTarget(self, action: #selector(handleNewTweet), for: .touchUpInside)
        
        let stack = UIStackView(arrangedSubviews: [UserImage, textLabel])
        stack.axis = .horizontal
        stack.spacing = 12
        
        view.addSubview(stack)
        stack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stack.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            stack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            stack.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20)
        ])
        
        UserImage.backgroundColor = .twitterBlue
    }
    
    func callUploadViewController() -> UINavigationController {
        let vc = UploadTweetControllerViewController(config: .tweet)
        let nav = UINavigationController(rootViewController: vc )
        return nav
    }
    
    func createUserImageInTwitter() {
        guard let userImage = user?.profileImage else { return }
        guard let imageURL = URL(string: userImage) else { return }

        UserImage.sd_setImage(with: imageURL, completed: nil)
    }
    
    //MARK: - Selectors
    
    @objc func handleCancelTweet() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func handleUploadTweet() {
        
    }
}
