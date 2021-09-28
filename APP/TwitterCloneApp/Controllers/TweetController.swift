//
//  TweetController.swift
//  TwitterCloneApp
//
//  Created by Paolo Prodossimo Lopes on 06/09/21.
//

import UIKit

private let reuseIdentifierForHeader = "TweetHeaderReuseIdentifier"
private let reuseIdentifierForTweetCell = "TweetCellREuseIdentifier"

class TweetController: UICollectionViewController {
    //MARK: - Properties
    private let tweet: String
    
    let arrayOfTweetsReplies = ["repplie 1", "replie 2", "replie 3", "replie 4",  "replie 4"]
    private let actionSheet: ActionSheetLoucher?
    
    //MARK: - LifeCicle
    
    init(tweet: String) {
        self.tweet = tweet
        self.actionSheet = ActionSheetLoucher()
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureConllectionView()
    }
    
    func configureConllectionView() {
        collectionView.backgroundColor = .white
        
        collectionView.register(TweetHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: reuseIdentifierForHeader)
        collectionView.register(TweetCell.self, forCellWithReuseIdentifier: reuseIdentifierForTweetCell)
        actionSheet?.delegate = self
    }
}

extension TweetController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrayOfTweetsReplies.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifierForTweetCell, for: indexPath) as! TweetCell
        cell.captionLAbel.text = arrayOfTweetsReplies[indexPath.row]
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: reuseIdentifierForHeader, for: indexPath) as! TweetHeader
        header.delegate = self
        header.username.text = arrayOfTweetsReplies[indexPath.row]
        return header
    }
}

extension TweetController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 120)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        let height = TwitterCloneApp.size("wdfqreqfwfwefqwdsfqqvsdrvsdfqdcqfdsq", forWidth: view.frame.width).height
        return CGSize(width: view.frame.width, height: height + 150)
    }
}

extension TweetController: TweetHeaderDelegate {
    func handleActionSheet() {
        actionSheet?.show()
    }
}

extension TweetController: ActionSheetLoucherDelegate {
    func didSelect(option: ActionSheetOptions) {
        switch option {
        case .follow(_):
            print("")
        case .unfollow(_):
            print("")
        case .report:
            print("")
        case .delete:
            print("")
        }
    }
    
}

