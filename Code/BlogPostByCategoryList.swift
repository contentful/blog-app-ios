//
//  BlogPostByCategoryList.swift
//  Blog
//
//  Created by Boris Bügling on 05/02/15.
//  Copyright (c) 2015 Contentful GmbH. All rights reserved.
//

import UIKit

class BlogPostByCategoryList: BlogPostList {
    weak var category: Category!

    override var predicate: String? {
        get { return String(format:"ANY category.identifier == '%@'", category!.identifier) }
        set { }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        showMetadataHeader()

        metadataViewController.metadata = PostListMetadata(body: category.categoryDescription, photo: category.icon, title: category.title)
        metadataViewController.numberOfPostsFormatString =  "%d posts in %@"
    }
}
