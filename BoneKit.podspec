#
# Be sure to run `pod lib lint BoneKit.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
s.name             = 'BoneKit'
s.version          = '0.3.0'
s.summary          = 'The bare bones kit for building iOS apps!'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

s.description      = <<-DESC
An essential tool kit for quickly building iOS applications 💀.
Main tools:
- Atomic Swift Wrapper
- HTTP Client
- Style kit
- Custom Controls
- Debug Logger
DESC

s.homepage         = 'https://github.com/mnorth719/BoneKit'
# s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
s.license          = { :type => 'MIT', :file => 'LICENSE' }
s.author           = { 'Matt North' => 'matt.north93@gmail.com' }
s.source           = { :git => 'https://github.com/mnorth719/BoneKit.git', :tag => s.version.to_s }
# s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

s.ios.deployment_target = '9.0'

s.source_files = 'BoneKit/Classes/**/*'

# s.public_header_files = 'Pod/Classes/**/*.h'

s.frameworks = 'UIKit'
s.dependency 'PromiseKit', '~> 4.4'
end
