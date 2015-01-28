//
//  BlogTests.swift
//  BlogTests
//
//  Created by Boris Bügling on 22/01/15.
//  Copyright (c) 2015 Contentful GmbH. All rights reserved.
//

import Blog
import UIKit
import XCTest

class BlogTests: XCTestCase {
    
    func testDateFormatter() {
        let dateFormatter = NSDateFormatter.customDateFormatter()

        let components = NSDateComponents()
        components.year = 2015
        components.month = 1
        components.day = 15
        components.hour = 12
        let date = NSCalendar.currentCalendar().dateFromComponents(components)

        let dateString = dateFormatter.stringFromDate(date!)
        XCTAssertEqual(dateString, "Jan 15, 2015", "")
    }
    
}
