//
//  AuthorViewController.swift
//  Blog
//
//  Created by Boris Bügling on 02/02/15.
//  Copyright (c) 2015 Contentful GmbH. All rights reserved.
//

class AuthorViewController: UIViewController {
    @IBOutlet weak var authorBio: UILabel!
    @IBOutlet weak var authorImage: UIImageView!
    @IBOutlet weak var authorName: UILabel!
    @IBOutlet weak var numberOfPostLabel: UILabel!

    weak var author: Author!
    weak var client: CDAClient!
    var numberOfPosts: Int {
        get { return 0 }
        set {
            numberOfPostLabel.text = String(format: "%d posts by %@", newValue, author.name)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        authorBio.font = UIFont.bodyTextFont().fontWithSize(13.0)
        authorBio.textColor = UIColor.contentfulDeactivatedColor()
        authorName.font = UIFont.boldTitleFont()
        numberOfPostLabel.font = UIFont.bodyTextFont()

        authorBio.text = author.biography
        authorImage.cda_setImageWithPersistedAsset(author.profilePhoto, client: client, size: authorImage.frame.size, placeholderImage: nil)
        authorName.text = author.name
    }
}
