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

#use_frameworks!

pod 'Bypass'
pod 'ContentfulDeliveryAPI', '~> 1.4.9'
pod 'ContentfulDialogs'
pod 'ContentfulPersistence'
pod 'ContentfulStyle', :head

target 'BlogTests', :exclusive => true do

pod 'FBSnapshotTestCase'

end

