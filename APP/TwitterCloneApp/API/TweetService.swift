//
//  TweetService.swift
//  TwitterCloneApp
//
//  Created by Paolo Prodossimo Lopes on 19/08/21.
//

import Firebase

struct TweetService {
    static let shared = TweetService()
    
    func uploadTweet(caption: String, completion: @escaping((DatabaseReference?, Error?) -> Void)) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        let value:[String : Any] = ["uid": uid, "timestamp" : Int(NSDate().timeIntervalSince1970), "likes" : 0, "retweets" : 0, "caption" : caption]
        
        REF_TWEETS.childByAutoId().updateChildValues(value) { (error, ref) in
            if let error = error {
                DEBUGMessage("Error: \(error.localizedDescription)")
                completion(nil, error)
            }
            completion(ref, nil)
        }
    }
    
    func fetchTweets(completion: @escaping ([Tweets]) -> Void) {
        var tweets = [Tweets]()
        
        REF_TWEETS.observe(.childAdded) { (snapshot) in
            DEBUGMessage("My snapShot is \(snapshot)")
            
            guard let dict = snapshot.value as? [String : Any] else { return }
            
            let tweetId = snapshot.key
            let tweet = Tweets(tweetID: tweetId, dict: dict)
            
            tweets.append(tweet)
            completion(tweets)
        }
    }
}
