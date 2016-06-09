//
//  Globals.swift
//  TwitterSampleApp
//
//  Created by Svit Zebec on 09/06/16.
//  Copyright © 2016 Svit Zebec. All rights reserved.
//

import Foundation

func performOnMainThread(closure: () -> ()) {
	dispatch_async(dispatch_get_main_queue(), closure)
}
