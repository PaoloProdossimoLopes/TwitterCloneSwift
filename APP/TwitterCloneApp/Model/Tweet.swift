//
//  Tweet.swift
//  TwitterCloneApp
//
//  Created by Paolo Prodossimo Lopes on 19/08/21.
//

import Foundation

struct Tweets {
    let caption: String
    let tweetID: String
    let uid: String
    let likes: Int
    let retweetCount: Int
    var timestamp: Date!
    var didLike: Bool = false
    
    init(tweetID: String, dict: [String : Any]) {
        self.tweetID = tweetID
        
        self.caption = dict["caption"] as? String ?? ""
        self.uid = dict["uid"] as? String ?? ""
        self.likes = dict["likes"] as? Int ?? 0
        self.retweetCount = dict["retweets"] as? Int ?? 0
        
        if let timestamp = dict["timestamp"] as? Double {
            self.timestamp = Date(timeIntervalSince1970: timestamp)
        }
    }
}
