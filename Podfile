plugin 'cocoapods-keys', {
  :project => 'Blog',
  :keys => [
    'BlogSpaceId',
    'BlogAccessToken'
  ]}

source 'https://github.com/CocoaPods/Specs'
source 'https://github.com/contentful/CocoaPodsSpecs'

platform :ios, '8.0'

inhibit_all_warnings!

target 'Blog' do

#use_frameworks!

# work with a local copy for simplicity's sake
pod 'ContentfulPersistence', :path => '../contentful-persistence.objc'

pod 'ContentfulDialogs'
pod 'ContentfulStyle'

end
