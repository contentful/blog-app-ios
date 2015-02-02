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

pod 'Bypass'
pod 'ContentfulDialogs'
pod 'ContentfulPersistence'
pod 'ContentfulStyle', :head

end

target 'BlogTests' do

pod 'FBSnapshotTestCase'

end

