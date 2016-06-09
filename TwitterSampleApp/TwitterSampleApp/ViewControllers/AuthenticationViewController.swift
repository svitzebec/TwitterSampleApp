//
//  ViewController.swift
//  TwitterSampleApp
//
//  Created by Svit Zebec on 09/06/16.
//  Copyright © 2016 Svit Zebec. All rights reserved.
//

import UIKit
import TwitterKit

class AuthenticationViewController: UIViewController {

	override func viewDidLoad() {
		super.viewDidLoad()
	}

	override func viewWillAppear(animated: Bool) {
		setUpLoginButton()
	}

	private func setUpLoginButton() {
		let logInButton = TWTRLogInButton(logInCompletion: { session, error in
			if let session = session {
				print("signed in as \(session.userName)")

				self.showTwitterFeed(session.userID)
			} else {
				print("error: \(error?.localizedDescription)")
			}
		})

		logInButton.center = self.view.center
		self.view.addSubview(logInButton)
	}

	private func showTwitterFeed(userID: String) {
//		let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
//		let twitterFeedViewController = mainStoryboard.instantiateViewControllerWithIdentifier("TwitterFeedViewController")

		let twitterFeedViewController = TwitterFeedViewController(userID: userID)

		presentViewController(twitterFeedViewController, animated: true, completion: nil)
	}

}

