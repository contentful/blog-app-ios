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
    class var PostContentTypeId: String { return "32D46deE6kkWUYaEk2mAOe" }

    var client: CDAClient { return manager.client }
    var manager: CoreDataManager

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

        super.init()
    }

    func performSynchronization(completion: (NSError!) -> Void) {
        manager.performSynchronizationWithSuccess({ () -> Void in
            completion(nil)
        }, failure: { (response, error) -> Void in
            completion(error)
        })
    }

}
