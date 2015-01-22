//
//  SyncInfo.swift
//  Blog
//
//  Created by Boris Bügling on 22/01/15.
//  Copyright (c) 2015 Contentful GmbH. All rights reserved.
//

import Foundation
import CoreData

class SyncInfo: NSManagedObject {

    @NSManaged var lastSyncTimestamp: NSDate
    @NSManaged var syncToken: String

}
