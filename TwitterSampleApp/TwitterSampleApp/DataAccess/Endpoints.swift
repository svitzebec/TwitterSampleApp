//
//  Endpoints.swift
//  TwitterSampleApp
//
//  Created by Svit Zebec on 10/06/16.
//  Copyright © 2016 Svit Zebec. All rights reserved.
//

class Endpoints {

	private static let apiBaseURL = "https://api.twitter.com/1.1"

	enum EndpointType {
		case GetHomeTimeline
	}

	class func endpointURL(endpointType: EndpointType) -> String {
		switch endpointType {
		case .GetHomeTimeline:
			return "\(apiBaseURL)/statuses/home_timeline.json"
		}
	}
}
