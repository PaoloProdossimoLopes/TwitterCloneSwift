//
//  FeedCntroller.swift
//  TwitterCloneApp
//
//  Created by Paolo Prodossimo Lopes on 16/05/21.
//

import Foundation
import UIKit
import SDWebImage



class FeedController: UICollectionViewController {
    
    // MARK: - Properties
    private let reusaeIdentifier = "Tweet-Cell"
    var user: User? {
        didSet {
            configureLeftNavigationBarButton()
        }
    }
    
    var tweets = ["Tweet 1", "Tweet 2", "Tweet 3", "Tweet 4", "Tweet 5"]
    
    // MARK: - LifeCicle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        fetchTweets()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.barStyle = .default
        navigationController?.navigationBar.isHidden = false
    }
    

    // MARK: - Helpers
    
    func fetchTweets() {
        TweetService.shared.fetchTweets { (tweets) in
            //
        }
    }
    
    func configureUI(){
        //Setando o logo
        let logoViewTitle = UIImageView(image: UIImage(named: "twitter_logo_blue"))
        logoViewTitle.contentMode = .scaleAspectFit
        logoViewTitle.setDimensions(width: 44, height: 44)
        navigationItem.titleView = logoViewTitle
        
        collectionView.register(TweetCell.self, forCellWithReuseIdentifier: reusaeIdentifier)
        collectionView.backgroundColor = .white
        
        
    
    }
    
    func configureLeftNavigationBarButton() {
        
        guard let user  =  user else { return }

        //Criando e adicionando o ImageProfile na navigationBar
        let ImagePofile = UIImageView()
        ImagePofile.backgroundColor = .twitterBlue
        ImagePofile.setDimensions(width: 32, height: 32)
        ImagePofile.layer.cornerRadius = 32 / 2
        ImagePofile.layer.masksToBounds = true
        
        guard let userImageURL = user.profileImage as? String else { return }
        guard let URLUSerImageConverted = URL(string: userImageURL) else { return }
        
        ImagePofile.sd_setImage(with: URLUSerImageConverted, completed: nil)
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: ImagePofile)
    }

}

extension FeedController { // metodos do UIColectionView
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tweets.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reusaeIdentifier, for: indexPath) as! TweetCell
        cell.delegate = self 
        cell.captionLAbel.text = tweets[indexPath.row]
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let controller = TweetController(tweet: tweets[indexPath.row])
        navigationController?.pushViewController(controller, animated: true)
    }
}

extension FeedController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = TwitterCloneApp.size("wdfqreqfwfwefqwdsfqqvsdrvsdfqdcqfdsq", forWidth: view.frame.width).height
        let size: CGSize = CGSize(width: collectionView.frame.width, height: height + 80)
        return size
    }
}

extension FeedController: TweetCellDeleagte {
    func handleLikeTweet(_ cell: TweetCell) {
        let tweets = Tweets(tweetID: "123131231", dict: ["":""])
        cell.tweet = tweets
        cell.tweet?.didLike.toggle()
        cell.changeLikeImage()
    }
    
    func handleReplyTweet(_ cell: TweetCell) {
        guard let tweet = cell.captionLAbel.text else { return }
        let tweets = Tweets(tweetID: "123131231", dict: ["":tweet])
        let vc = UploadTweetControllerViewController(config: .replie(tweets))
        let nav = UINavigationController(rootViewController: vc)
        nav.modalPresentationStyle = .fullScreen
        present(nav, animated: true, completion: nil)
    }
    
    func handlerOpenProfilleController() {
        let vc = PerfilViewController(collectionViewLayout: UICollectionViewFlowLayout())
        navigationController?.pushViewController(vc, animated: true)
    }
}
