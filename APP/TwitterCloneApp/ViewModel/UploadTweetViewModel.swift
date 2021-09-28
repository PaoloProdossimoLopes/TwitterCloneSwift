//
//  UploadTweetViewModel.swift
//  TwitterCloneApp
//
//  Created by Paolo Prodossimo Lopes on 09/09/21.
//

import UIKit

struct UploadTweetViewModel {
    let actionButtonTitle: String
    let placeHolderText: String
    var shouldShoeReplyLabel: Bool
    var replyText: String?
    
    init(config: UploadTweetConfiguration) {
        switch config {
        case .tweet:
            actionButtonTitle = "Tweet"
            placeHolderText = "What's happening.."
            shouldShoeReplyLabel = false
        case .replie(let tweet):
            actionButtonTitle = "Reply"
            placeHolderText = "Tweet your reply"
            shouldShoeReplyLabel = true
            replyText = "Replying to @\(tweet.uid)"
        }
    }
}
