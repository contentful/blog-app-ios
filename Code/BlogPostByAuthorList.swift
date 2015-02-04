//
//  BlogPostByAuthorList.swift
//  Blog
//
//  Created by Boris Bügling on 02/02/15.
//  Copyright (c) 2015 Contentful GmbH. All rights reserved.
//

import UIKit

class BlogPostByAuthorList: BlogPostList {
    var authorViewController: AuthorViewController!

    weak var author: Author!

    override var predicate: String? {
        get { return String(format:"ANY author.identifier == '%@'", author!.identifier) }
        set { }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        showsAuthor = false

        tableView.contentInset = UIEdgeInsets(top: 20.0, left: 0.0, bottom: 0.0, right: 0.0)

        authorViewController = storyboard?.instantiateViewControllerWithIdentifier(ViewControllerStoryboardIdentifier.AuthorViewControllerId.rawValue) as AuthorViewController
        authorViewController.author = author
        authorViewController.client = dataManager?.client
        authorViewController.view.autoresizingMask = .None
        authorViewController.view.frame.size.height = 160.0

        tableView.tableHeaderView = authorViewController.view
    }

    // MARK: UITableViewDelegate

    override func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        authorViewController.numberOfPosts = tableView.numberOfRowsInSection(0)
    }
}
