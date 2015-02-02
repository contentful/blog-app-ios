//
//  BlogPostList.swift
//  Blog
//
//  Created by Boris Bügling on 22/01/15.
//  Copyright (c) 2015 Contentful GmbH. All rights reserved.
//

import UIKit

class BlogPostListCell : UITableViewCell {
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style:.Subtitle, reuseIdentifier: reuseIdentifier)
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        textLabel?.frame.origin.y = 0.0
        textLabel?.frame.size.height = 55.0
        detailTextLabel?.frame.origin.y = (textLabel?.frame.maxY)!
    }
}

class BlogPostList: UITableViewController {
    var dataManager: ContentfulDataManager? = nil
    var dataSource: CoreDataFetchDataSource? = nil
    var predicate: String? = nil

    func refresh() {
        dataManager?.performSynchronization({ (error) -> Void in
            if error != nil && error.code != NSURLErrorNotConnectedToInternet {
                let alert = UIAlertView(title: NSLocalizedString("Error", comment: ""), message: error.localizedDescription, delegate: nil, cancelButtonTitle: NSLocalizedString("OK", comment: ""))
                alert.show()
            }

            self.dataSource?.performFetch()
        })
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        addInfoButton()

        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.Plain, target: nil, action: nil)

        dataManager = ContentfulDataManager()

        let controller = dataManager?.fetchedResultsControllerForContentType(ContentfulDataManager.PostContentTypeId, predicate: predicate, sortDescriptors: [NSSortDescriptor(key: "date", ascending: true)])
        let tableView = self.tableView!
        dataSource = CoreDataFetchDataSource(fetchedResultsController: controller, tableView: tableView, cellIdentifier: NSStringFromClass(BlogPostList.self))

        dataSource?.cellConfigurator = { (cell, indexPath) -> Void in
            if let tcell = cell as? UITableViewCell {
                tcell.accessoryType = .DisclosureIndicator
                tcell.detailTextLabel?.font = UIFont.bodyTextFont().fontWithSize(12.0)
                tcell.detailTextLabel?.textColor = UIColor.contentfulDeactivatedColor()
                tcell.selectionStyle = .None
                tcell.textLabel?.font = UIFont.titleBarFont()
                tcell.textLabel?.numberOfLines = 2

                if tcell.respondsToSelector("setLayoutMargins:") {
                    tcell.layoutMargins = UIEdgeInsetsZero
                    tcell.preservesSuperviewLayoutMargins = false
                }

                if let post = self.dataSource?.objectAtIndexPath(indexPath) as? Post {
                    tcell.textLabel?.text = post.title

                    let dateString = NSDateFormatter.customDateFormatter().stringFromDate(post.date)
                    tcell.detailTextLabel?.text = String(format:"%@. by %@", dateString, post.author.name).uppercaseString
                }
            }
        }

        tableView.dataSource = dataSource
        tableView.rowHeight = 80.0
        tableView.separatorInset = UIEdgeInsetsZero

        tableView.registerClass(BlogPostListCell.self, forCellReuseIdentifier: NSStringFromClass(BlogPostList.self))
    }

    override func viewWillAppear(animated: Bool) {
        refresh()
    }

    // MARK: UITableViewDelegate

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if let post = self.dataSource?.objectAtIndexPath(indexPath) as? Post {
            let identifier = ViewControllerStoryboardIdentifier.BlogPostViewControllerId.rawValue
            let blogPostViewController = storyboard?.instantiateViewControllerWithIdentifier(identifier) as? BlogPostViewController
            blogPostViewController?.post = post

            navigationController?.pushViewController(blogPostViewController!, animated: true)
        }
    }
}
