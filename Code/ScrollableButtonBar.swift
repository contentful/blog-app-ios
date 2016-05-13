//
//  ScrollableButtonBar.swift
//  Blog
//
//  Created by Boris Bügling on 05/02/15.
//  Copyright (c) 2015 Contentful GmbH. All rights reserved.
//

import UIKit

class ScrollableButtonBar: UIViewController {
    var tapHandler: ((tappedObject: AnyObject) -> (Void))?
    var titleKey = "title"

    var objects: NSArray = [] {
        didSet {
            let scrollView = UIScrollView(frame: view.bounds)
            scrollView.autoresizingMask = .FlexibleWidth
            view.addSubview(scrollView)

            var x = CGFloat(0.0), maxHeight = CGFloat(0.0)
            for (index, object) in objects.enumerate() {
                let button = UIButton(type:.System) as UIButton
                button.addTarget(self, action: #selector(ScrollableButtonBar.tapped(_:)), forControlEvents: .TouchUpInside)
                button.frame.origin.x = x
                button.setTitle(object.valueForKey(titleKey) as? String, forState: .Normal)
                button.tag = index
                button.titleLabel?.font = UIFont.bodyTextFont().fontWithSize(12.0)
                button.frame.size = button.intrinsicContentSize()
                scrollView.addSubview(button)

                maxHeight = max(maxHeight, button.frame.size.height)
                x += button.frame.size.width + 10.0
            }

            scrollView.frame.size.height = maxHeight
            scrollView.contentSize = CGSize(width: x, height: scrollView.frame.size.height)
        }
    }

    func tapped(sender: UIButton) {
        if let tapHandler = tapHandler {
            tapHandler(tappedObject: objects[sender.tag])
        }
    }
}
