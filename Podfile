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

target 'Blog' do

pod 'Bypass'
pod 'ContentfulDeliveryAPI', '~> 1.4.9'
pod 'ContentfulDialogs'
pod 'ContentfulPersistence'
pod 'ContentfulStyle', :git => 'https://github.com/contentful/contentful-ios-style.git'

end

target 'BlogTests' do

pod 'FBSnapshotTestCase'

end

