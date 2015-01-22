//
//  AppDelegate.swift
//  Blog
//
//  Created by Boris Bügling on 22/01/15.
//  Copyright (c) 2015 Contentful GmbH. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    class var AccessToken: String { return "ContentfulAccessToken" }
    class var SpaceKey: String { return "ContentfulSpaceKey" }

    var window: UIWindow?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        writeKeysToUserDefaults()

        window?.backgroundColor = UIColor.whiteColor()
        return true
    }

    func writeKeysToUserDefaults() {
        let defaults = NSUserDefaults.standardUserDefaults()
        let keys = BlogKeys()

        if defaults.stringForKey(AppDelegate.SpaceKey) == nil {
            defaults.setValue(keys.blogSpaceId(), forKey: AppDelegate.SpaceKey)
        }

        if defaults.stringForKey(AppDelegate.AccessToken) == nil {
            defaults.setValue(keys.blogAccessToken(), forKey: AppDelegate.AccessToken)
        }
    }

}

