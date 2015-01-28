//
//  BlogPostViewController.swift
//  Blog
//
//  Created by Boris Bügling on 23/01/15.
//  Copyright (c) 2015 Contentful GmbH. All rights reserved.
//

import UIKit

class BlogPostViewController: UIViewController {
    @IBOutlet weak var bodyView: UITextView!
    @IBOutlet weak var metadataLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!

    weak var post: Post!

    func attributedString(fromString: String, _ lineHeight: CGFloat) -> NSAttributedString {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = lineHeight

        return NSAttributedString(string: fromString, attributes: [NSParagraphStyleAttributeName: paragraphStyle])
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        let scrollView = view as UIScrollView
        scrollView.contentSize = CGSize(width: scrollView.frame.size.width,
            height: bodyView.frame.origin.y + bodyView.intrinsicContentSize().height)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        bodyView.font = UIFont(name: "PT Serif", size: 15.0)
        bodyView.textContainerInset = UIEdgeInsets(top: 0.0, left: 10.0, bottom: 40.0, right: 10.0)

        metadataLabel.font = UIFont.bodyTextFont().fontWithSize(12.0)
        metadataLabel.textColor = UIColor.contentfulDeactivatedColor()
        titleLabel.font = UIFont.boldTitleFont().fontWithSize(24.0)

        bodyView.text = post.body
        titleLabel.text = post.title

        let dateString = NSDateFormatter.customDateFormatter().stringFromDate(post.date)
        let metadataString = String(format:"%@. by %@", dateString, post.author.name).uppercaseString
        metadataLabel.attributedText = attributedString(metadataString, metadataLabel.font.lineHeight * 1.5)
    }
}
