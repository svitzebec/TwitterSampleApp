//
//  TwitterFeedViewController.swift
//  TwitterSampleApp
//
//  Created by Svit Zebec on 09/06/16.
//  Copyright © 2016 Svit Zebec. All rights reserved.
//

import UIKit
import TwitterKit

class TwitterFeedViewController: TWTRTimelineViewController {

	convenience init(userID: String) {
		let client = TWTRAPIClient(userID: userID)

		let dataSource = TWTRUserTimelineDataSource(screenName: "fabric", userID: userID, APIClient: client, maxTweetsPerRequest: 0, includeReplies: true, includeRetweets: true)
		self.init(dataSource: dataSource)
	}

	override required init(dataSource: TWTRTimelineDataSource?) {
		super.init(dataSource: dataSource)
	}
	
	required init(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	override func viewDidLoad() {
		super.viewDidLoad()
	}
}
