//
//  BlogPostViewController.swift
//  Blog
//
//  Created by Boris Bügling on 23/01/15.
//  Copyright (c) 2015 Contentful GmbH. All rights reserved.
//

import UIKit

class BlogPostViewController: UIViewController {
    @IBOutlet weak var authorButton: UIButton!
    @IBOutlet weak var bodyView: UITextView!
    @IBOutlet weak var categoriesLabel: UILabel!
    @IBOutlet weak var metadataLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!

    weak var post: Post!

    func attributedString(fromString: String, _ lineHeight: CGFloat) -> NSAttributedString {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = lineHeight

        return NSAttributedString(string: fromString, attributes: [NSParagraphStyleAttributeName: paragraphStyle])
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == SegueIdentifier.BlogPostByAuthorSegue.rawValue {
            let destination = segue.destinationViewController as BlogPostByAuthorList
            destination.author = post.author
        }
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        let scrollView = view as UIScrollView
        scrollView.contentSize = CGSize(width: scrollView.frame.size.width,
            height: bodyView.frame.origin.y + bodyView.intrinsicContentSize().height + categoriesLabel.intrinsicContentSize().height)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        addInfoButton()

        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.Plain, target: nil, action: nil)

        bodyView.textContainerInset = UIEdgeInsets(top: 0.0, left: 10.0, bottom: 40.0, right: 10.0)

        authorButton.titleLabel?.font = UIFont.bodyTextFont().fontWithSize(12.0)
        categoriesLabel.font = UIFont.bodyTextFont().fontWithSize(12.0)
        categoriesLabel.textColor = UIColor.contentfulDeactivatedColor()
        metadataLabel.font = UIFont.bodyTextFont().fontWithSize(12.0)
        metadataLabel.textColor = UIColor.contentfulDeactivatedColor()
        titleLabel.font = UIFont.boldTitleFont().fontWithSize(24.0)

        let parser = BPParser()
        let document = parser.parse(post.body)
        let converter = BPAttributedStringConverter()
        converter.displaySettings.defaultFont = UIFont(name: "PT Serif", size: 15.0)
        bodyView.attributedText = converter.convertDocument(document)

        if let author = post.author {
            authorButton.setTitle(author.name.uppercaseString, forState: .Normal)
        } else {
            authorButton.enabled = false
        }

        categoriesLabel.text = String(format:NSLocalizedString("Published under %@", comment: ""), post.category != nil ? post.category! : "").uppercaseString
        titleLabel.text = post.title

        if let date = post.date {
            let dateString = NSDateFormatter.customDateFormatter().stringFromDate(date)
            let metadataString = String(format:"%@. by", dateString).uppercaseString
            metadataLabel.attributedText = attributedString(metadataString, metadataLabel.font.lineHeight * 1.5)
        }
    }
}
