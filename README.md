# Blog

[![](https://assets.contentful.com/7clmb9ye18e7/9prTbbpxsWgQ0K6qAEyY6/cd3d2a09a6110ce61d06cea59d4cf62a/download-store.svg)](https://itunes.apple.com/app/id962456216)

This is an iOS application example for the [Contentful][1] blog space template.

[Contentful][1] is a content management platform for web applications, mobile apps and connected devices. It allows you to create, edit & manage content in the cloud and publish it anywhere via powerful API. Contentful offers tools for managing editorial teams and enabling cooperation between organizations.

## Usage

- Simply run

```
$ make setup
```

This will install all necessary RubyGems, create a new space on [Contentful][1] using 
[Contentful Bootstrap][3], install all necessary [CocoaPods][2] and setup API keys automatically.

- Now you're ready to use it!

## Customizing

- You can easily drop the [Contentful][1] related branding by removing 'ContentfulDialogs' and 'ContentfulStyle' from the Podfile. You will need to remove the `addInfoButton()` function from the `UIViewController` extension, as well as replace usages of our fonts and colors. In addition to that, update the bridging header as there are now some header files missing.

- The app has support for the 'contentful-blog://' custom URL scheme, you should also remove that if you are using the template for your own application.

## License

Copyright (c) 2015 Contentful GmbH. See LICENSE for further details.


[1]: https://www.contentful.com
[2]: http://cocoapods.org
[3]: https://github.com/contentful-labs/contentful-bootstrap.rb
