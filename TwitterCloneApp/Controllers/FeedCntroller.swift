//
//  FeedCntroller.swift
//  TwitterCloneApp
//
//  Created by Paolo Prodossimo Lopes on 16/05/21.
//

import Foundation
import UIKit

class FeedController: UIViewController {
    
    // MARK: - Properties
    
    // MARK: - LifeCicle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()

    }
    

    // MARK: - Helpers
    
    func configureUI(){
        
        //Setando o logo
        let logoViewTitle = UIImageView(image: UIImage(named: "twitterLogo"))
        logoViewTitle.contentMode = .scaleAspectFit
        navigationItem.titleView = logoViewTitle
    }

}
