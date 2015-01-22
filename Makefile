.PHONY: all storyboard_ids

all:
	xcodebuild -workspace 'Blog.xcworkspace' -scheme 'Blog'|xcpretty

storyboard_ids:
	bundle exec sbconstants --swift Code/StoryboardIdentifiers.swift
