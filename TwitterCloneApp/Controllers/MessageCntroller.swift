//
//  MessageCntroller.swift
//  TwitterCloneApp
//
//  Created by Paolo Prodossimo Lopes on 16/05/21.
//

import Foundation
import UIKit

class MessageController: UIViewController {
    
    // MARK: - Properties
    
    // MARK: - LifeCicle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        
    }
    

    // MARK: - Helpers
    func configureUI(){
        navigationItem.title = "Messages"
    }
}
