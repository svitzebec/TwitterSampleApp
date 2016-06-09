//
//  TwitterHomeViewController.swift
//  TwitterSampleApp
//
//  Created by Svit Zebec on 09/06/16.
//  Copyright © 2016 Svit Zebec. All rights reserved.
//

import UIKit
import TwitterKit

class TwitterHomeViewController: UITableViewController {

	private var tweets = [TWTRTweet]()
	private var isLoadingOlderTweets = false
	private var olderTweetsFetchBlocked = false

	private var oldestTweetID: String? {
		return tweets.last?.tweetID
	}

	override func viewDidLoad() {
		super.viewDidLoad()

		DataAccessHandler.shared.fetchTweets(oldestTweetID, completion: { fetchedTweets in
			if let fetchedTweets = fetchedTweets {
				self.tweets = fetchedTweets

				performOnMainThread {
					self.tableView.reloadData()
				}
			}
		})
	}

	override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return tweets.count
	}

	override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		let cell = TWTRTweetTableViewCell()
		cell.configureWithTweet(tweets[indexPath.row])

		return cell
	}

	override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
		return TWTRTweetTableViewCell.heightForTweet(tweets[indexPath.row], style: TWTRTweetViewStyle.Compact, width: tableView.frame.width, showingActions: false)
	}

	override func scrollViewDidScroll(scrollView: UIScrollView) {
		if tableView.contentOffset.y >= tableView.contentSize.height - tableView.frame.size.height {
			// did scroll to the bottom of the table view

			if !olderTweetsFetchBlocked && !isLoadingOlderTweets {
				loadOlderTweets()
			}

			if !olderTweetsFetchBlocked {
				NSTimer.scheduledTimerWithTimeInterval(5, target: self, selector: #selector(olderTweetsTimerFinished), userInfo: nil, repeats: false)
				olderTweetsFetchBlocked = true
			}
		}
	}

	func olderTweetsTimerFinished() {
		olderTweetsFetchBlocked = false
	}

	private func loadOlderTweets() {
		isLoadingOlderTweets = true
		DataAccessHandler.shared.fetchTweets(oldestTweetID, completion: { fetchedTweets in
			guard let fetchedTweets = fetchedTweets else {
				self.isLoadingOlderTweets = false
				return
			}

			self.tweets.appendContentsOf(fetchedTweets)
			self.tableView.reloadData()

			self.isLoadingOlderTweets = false
		})
	}


}
