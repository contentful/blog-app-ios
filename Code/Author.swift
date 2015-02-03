//
//  Author.swift
//  Blog
//
//  Created by Boris Bügling on 22/01/15.
//  Copyright (c) 2015 Contentful GmbH. All rights reserved.
//

import Foundation
import CoreData

class Author: NSManagedObject, CDAPersistedEntry {

    @NSManaged var biography: String?
    @NSManaged var identifier: String
    @NSManaged var name: String
    @NSManaged var website: String?
    @NSManaged var createdEntries: NSOrderedSet
    @NSManaged var profilePhoto: Asset?

}
