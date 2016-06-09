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

		setUpLoginButton()
	}

	private func setUpLoginButton() {
		let logInButton = TWTRLogInButton(logInCompletion: { session, error in
			if let session = session {
				print("signed in as \(session.userName)")

				DataAccessHandler.shared.apiClient = TWTRAPIClient(userID: session.userID)

				self.showTwitterFeed()
			} else {
				print("error: \(error?.localizedDescription)")
			}
		})

		logInButton.center = self.view.center
		self.view.addSubview(logInButton)
	}

	private func showTwitterFeed() {
		let twitterHomeViewController = TwitterHomeViewController()
		let navigationController = UINavigationController(rootViewController: twitterHomeViewController)
		navigationController.title = "Home feed"

		presentViewController(navigationController, animated: true, completion: nil)
	}

}

