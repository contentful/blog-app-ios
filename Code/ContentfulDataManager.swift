//
//  ContentfulDataManager.swift
//  Blog
//
//  Created by Boris Bügling on 22/01/15.
//  Copyright (c) 2015 Contentful GmbH. All rights reserved.
//

import UIKit

class ContentfulDataManager: NSObject {
    class var AuthorContentTypeId: String { return "1kUEViTN4EmGiEaaeC6ouY" }
    class var CategoryContentTypeId: String { return "5KMiN6YPvi42icqAUQMCQe" }
    class var PostContentTypeId: String { return "2wKn6yEnZewu2SCCkus4as" }

    var client: CDAClient { return manager.client }
    var manager: CoreDataManager
    var notificationToken: NSObjectProtocol? = nil

    deinit {
        if let token = self.notificationToken {
            NSNotificationCenter.defaultCenter().removeObserver(token)
        }
    }

    func fetchedResultsControllerForContentType(identifier: String, predicate: String?, sortDescriptors: [NSSortDescriptor]) -> NSFetchedResultsController {
        let fetchRequest = manager.fetchRequestForEntriesOfContentTypeWithIdentifier(identifier, matchingPredicate: predicate)
        fetchRequest.sortDescriptors = sortDescriptors

        return NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: manager.managedObjectContext, sectionNameKeyPath: nil, cacheName: nil)
    }

    override init() {
        let client = CDAClient(spaceKey: NSUserDefaults.standardUserDefaults().stringForKey(AppDelegate.SpaceKey), accessToken: NSUserDefaults.standardUserDefaults().stringForKey(AppDelegate.AccessToken))
        manager = CoreDataManager(client: client, dataModelName: "Blog")

        manager.classForAssets = Asset.self
        manager.classForSpaces = SyncInfo.self

        manager.setClass(Post.self, forEntriesOfContentTypeWithIdentifier: ContentfulDataManager.PostContentTypeId)
        manager.setClass(Author.self, forEntriesOfContentTypeWithIdentifier: ContentfulDataManager.AuthorContentTypeId)
        manager.setClass(Category.self, forEntriesOfContentTypeWithIdentifier: ContentfulDataManager.CategoryContentTypeId)

        manager.setMapping([ "fields.title": "title", "fields.icon": "icon", "fields.shortDescription": "categoryDescription" ], forEntriesOfContentTypeWithIdentifier: ContentfulDataManager.CategoryContentTypeId)

        super.init()

        notificationToken = NSNotificationCenter.defaultCenter().addObserverForName(AppDelegate.SpaceChangedNotification, object: nil, queue: NSOperationQueue.mainQueue(), usingBlock: { [unowned self] (note: NSNotification?) -> Void in
            if let note = note {
                self.manager.deleteAll()

                let defaults = NSUserDefaults.standardUserDefaults()
                defaults.setValue(note.userInfo![AppDelegate.SpaceKey], forKey: AppDelegate.SpaceKey)
                defaults.setValue(note.userInfo![AppDelegate.AccessToken], forKey: AppDelegate.AccessToken)

                let keyWindow = UIApplication.sharedApplication().keyWindow!
                keyWindow.rootViewController = keyWindow.rootViewController?.storyboard?.instantiateInitialViewController() as? UIViewController
            }
        })
    }

    func performSynchronization(completion: (NSError!) -> Void) {
        manager.performSynchronizationWithSuccess({ () -> Void in
            completion(nil)
        }, failure: { (response, error) -> Void in
            completion(error)
        })
    }

}
