//
//  DataAccessHandler.swift
//  TwitterSampleApp
//
//  Created by Svit Zebec on 09/06/16.
//  Copyright © 2016 Svit Zebec. All rights reserved.
//

import Foundation
import TwitterKit

class DataAccessHandler {

	static let shared = DataAccessHandler()

	var apiClient: TWTRAPIClient?

	func fetchTweets(oldestTweetID: String?, completion: (fetchedTweets: [TWTRTweet]?) -> ()) {
		var error: NSError?

		guard let client = apiClient else {
			print("Error when obtaining the api client")
			completion(fetchedTweets: nil)
			return
		}

		var URLString = Endpoints.endpointURL(.GetHomeTimeline)

		if let oldestTweetID = oldestTweetID {
			URLString.appendContentsOf("?max_id=\(oldestTweetID)")
		}

		let request = client.URLRequestWithMethod("GET", URL: URLString, parameters: nil, error: &error)

		client.sendTwitterRequest(request, completion: { (response, data, connectionError) -> Void in
			if let connectionError = connectionError {
				print("Connection error: \(connectionError.localizedDescription)")
				completion(fetchedTweets: nil)
			}

			do {
				guard let _ = response, let data = data else {
					print("Problem with obtaining feed.")
					completion(fetchedTweets: nil)
					return
				}
				let json = try NSJSONSerialization.JSONObjectWithData(data, options: [])

				if let jsonTweetList = json as? [[String : AnyObject]] {
					print(jsonTweetList)

					let tweets = TWTRTweet.tweetsWithJSONArray(jsonTweetList)
					let tweetObjects = tweets.map { $0 as! TWTRTweet }

					completion(fetchedTweets: tweetObjects)
				}
			} catch let jsonError as NSError {
				print("JSON error: \(jsonError.localizedDescription)")
			}
		})

		completion(fetchedTweets: nil)
	}
}
