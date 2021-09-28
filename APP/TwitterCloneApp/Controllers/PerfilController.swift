//
//  PerfilController.swift
//  TwitterCloneApp
//
//  Created by Paolo Prodossimo Lopes on 04/09/21.
//

import UIKit

class PerfilViewController: UICollectionViewController {
    private let reusaeIdentifier = "Tweet-Cell"
    private let profileHeaderIdentifier = "ProfileHeader"
    
    var username: String = "Full Name"
    
//    private let user: User? = nil
    
    
//    init(user: User) {
//        self.user = user
//        super.init(collectionViewLayout: UICollectionViewLayout())
//    }
    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    func configureCollectionView() {
        navigationController?.navigationBar.isHidden = true
        collectionView.contentInsetAdjustmentBehavior = .never
        collectionView.backgroundColor = .white
        
        collectionView.register(TweetCell.self, forCellWithReuseIdentifier: reusaeIdentifier)
        collectionView.register(ProfileHeader.self,
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                withReuseIdentifier: profileHeaderIdentifier)
        
    }
}

extension PerfilViewController {
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: profileHeaderIdentifier, for: indexPath)
        guard let headerProfile = header as? ProfileHeader else { return header }
        headerProfile.delegate = self
        headerProfile.fullNameLabel.text = username
//        headerProfile.user = user
        return headerProfile
    }
}

extension PerfilViewController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reusaeIdentifier, for: indexPath) as! TweetCell
        return cell
    }
}

extension PerfilViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 350)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 120)
    }
}

extension PerfilViewController: ProfileHeaderDelegate {
    func handlerDismiss() {
        navigationController?.popViewController(animated: true)
    }
}
