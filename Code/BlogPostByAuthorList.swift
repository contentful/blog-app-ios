//
//  BlogPostByAuthorList.swift
//  Blog
//
//  Created by Boris Bügling on 02/02/15.
//  Copyright (c) 2015 Contentful GmbH. All rights reserved.
//

import UIKit

class BlogPostByAuthorList: BlogPostList {
    weak var author: Author!

    override var predicate: String? {
        get { return String(format:"ANY author.identifier == '%@'", author!.identifier) }
        set { }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        showsAuthor = false
        showMetadataHeader()

        metadataViewController.metadata = PostListMetadata(body: author.biography, photo: author.profilePhoto, title: author.name)
    }
}
