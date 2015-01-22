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
}

class BlogPostList: UITableViewController {
    var dataManager: ContentfulDataManager? = nil
    var dataSource: CoreDataFetchDataSource? = nil

    override func awakeFromNib() {
        dataManager = ContentfulDataManager()

        let controller = dataManager?.fetchedResultsControllerForContentType(ContentfulDataManager.PostContentTypeId, predicate: nil, sortDescriptors: [NSSortDescriptor(key: "date", ascending: true)])
        let tableView = self.tableView!
        dataSource = CoreDataFetchDataSource(fetchedResultsController: controller, tableView: tableView, cellIdentifier: NSStringFromClass(BlogPostList.self))

        dataSource?.cellConfigurator = { (cell, indexPath) -> Void in
            if let tcell = cell as? UITableViewCell {
                if let post = self.dataSource?.objectAtIndexPath(indexPath) as? Post {
                    tcell.textLabel!.text = post.title
                    tcell.detailTextLabel!.text = NSDateFormatter().stringFromDate(post.date)
                }
            }
        }

        tableView.dataSource = dataSource
    }

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
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.Plain, target: nil, action: nil)

        tableView.registerClass(BlogPostListCell.self, forCellReuseIdentifier: NSStringFromClass(BlogPostList.self))
    }

    override func viewWillAppear(animated: Bool) {
        refresh()
    }

    // MARK: UITableViewDelegate

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if let post = self.dataSource?.objectAtIndexPath(indexPath) as? Post {
            let identifier = ViewControllerStoryboardIdentifier.BlogPostViewControllerId.rawValue
            let blogPostViewController = storyboard?.instantiateViewControllerWithIdentifier(identifier) as? UIViewController

            navigationController?.pushViewController(blogPostViewController!, animated: true)
        }
    }
}
