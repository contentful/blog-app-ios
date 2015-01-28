//
//  CustomDateFormatter.swift
//  Blog
//
//  Created by Boris Bügling on 28/01/15.
//  Copyright (c) 2015 Contentful GmbH. All rights reserved.
//

import Foundation

public extension NSDateFormatter {
    public class func customDateFormatter() -> NSDateFormatter {
        let formatString = NSDateFormatter.dateFormatFromTemplate("dd. MMM yyyy", options: 0, locale: NSLocale.currentLocale())

        let formatter = NSDateFormatter()
        formatter.dateFormat = formatString

        return formatter
    }
}
