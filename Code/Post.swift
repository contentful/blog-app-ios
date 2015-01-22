//
//  Post.swift
//  Blog
//
//  Created by Boris Bügling on 22/01/15.
//  Copyright (c) 2015 Contentful GmbH. All rights reserved.
//

import Foundation
import CoreData

class Post: NSManagedObject {

    @NSManaged var body: String
    @NSManaged var category: String
    @NSManaged var comments: NSNumber
    @NSManaged var date: NSDate
    @NSManaged var identifier: String
    @NSManaged var slug: String
    @NSManaged var title: String
    @NSManaged var author: Author
    @NSManaged var featuredImage: Asset

}
