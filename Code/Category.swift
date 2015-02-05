//
//  Category.swift
//  Blog
//
//  Created by Boris Bügling on 05/02/15.
//  Copyright (c) 2015 Contentful GmbH. All rights reserved.
//

import Foundation
import CoreData

class Category: NSManagedObject, CDAPersistedEntry {

    @NSManaged var identifier: String
    @NSManaged var categoryDescription: String?
    @NSManaged var title: String
    @NSManaged var categoryInverse: NSSet
    @NSManaged var icon: Asset?

}
