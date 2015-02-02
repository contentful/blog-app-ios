//
//  BlogPostByAuthorList.swift
//  Blog
//
//  Created by Boris Bügling on 02/02/15.
//  Copyright (c) 2015 Contentful GmbH. All rights reserved.
//

class BlogPostByAuthorList: BlogPostList {
    var author: Author? = nil

    override var predicate: String? {
        get { return String(format:"ANY author.identifier == '%@'", author!.identifier) }
        set { }
    }
}
