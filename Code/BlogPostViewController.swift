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
    @IBOutlet weak var categoriesLabel: UILabel!
    @IBOutlet weak var coverImageView: UIImageView!
    @IBOutlet weak var metadataLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!

    weak var client: CDAClient!
    weak var post: Post!

    func attributedString(fromString: String, _ lineHeight: CGFloat) -> NSAttributedString {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = lineHeight

        return NSAttributedString(string: fromString, attributes: [NSParagraphStyleAttributeName: paragraphStyle])
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == SegueIdentifier.BlogPostByAuthorSegue.rawValue {
            let destination = segue.destinationViewController as BlogPostByAuthorList
            destination.author = sender as Author
        }

        if segue.identifier == SegueIdentifier.EmbedAuthorsBarSegue.rawValue {
            if let authors = post.author {
                let destination = segue.destinationViewController as ScrollableButtonBar
                destination.titleKey = "name"
                destination.objects = authors.array

                destination.tapHandler = { (object: AnyObject) -> Void in
                    self.performSegueWithIdentifier(SegueIdentifier.BlogPostByAuthorSegue.rawValue, sender: object as Author)
                }
            }
        }

        if segue.identifier == SegueIdentifier.EmbedCategoriesBarSegue.rawValue {
            if let categories = post.category {
                let destination = segue.destinationViewController as ScrollableButtonBar
                destination.objects = categories.array
            }
        }
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        let scrollView = view as UIScrollView
        scrollView.contentSize = CGSize(width: scrollView.frame.size.width,
            height: bodyView.frame.origin.y + bodyView.intrinsicContentSize().height + categoriesLabel.intrinsicContentSize().height + 10.0)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        addInfoButton()

        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.Plain, target: nil, action: nil)

        bodyView.textContainerInset = UIEdgeInsets(top: 0.0, left: 10.0, bottom: 40.0, right: 10.0)

        coverImageView.offlineCaching_cda = true
        coverImageView.cda_setImageWithPersistedAsset(post.featuredImage, client: client, size: coverImageView.frame.size, placeholderImage: nil)

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

        titleLabel.text = post.title

        if let date = post.date {
            let dateString = NSDateFormatter.customDateFormatter().stringFromDate(date)
            let metadataString = String(format:"%@. by", dateString).uppercaseString
            metadataLabel.attributedText = attributedString(metadataString, metadataLabel.font.lineHeight * 1.5)
        }
    }
}
