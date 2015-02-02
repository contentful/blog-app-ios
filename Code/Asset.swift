//
//  Asset.swift
//  Blog
//
//  Created by Boris Bügling on 22/01/15.
//  Copyright (c) 2015 Contentful GmbH. All rights reserved.
//

import Foundation
import CoreData

class Asset: NSManagedObject, CDAPersistedAsset {

    @NSManaged var height: NSNumber
    @NSManaged var identifier: String
    @NSManaged var internetMediaType: String
    @NSManaged var url: String
    @NSManaged var width: NSNumber
    @NSManaged var AuthorInverse: NSSet
    @NSManaged var PostInverse: NSSet

}
