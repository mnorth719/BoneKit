#
# Be sure to run `pod lib lint MattKit.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'MattKit'
  s.version          = '0.1.0'
  s.summary          = 'The essential kit for building iOS apps!'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
The essential tool kit for quickly building iOS applications.
Main tools:
- Atomic Swift Wrapper
- HTTP Client
- Style kit
- Custom Controls
                       DESC

  s.homepage         = 'https://github.com/mnorth719/MattKit'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Matt North' => 'matt.north93@gmail.com' }
  s.source           = { :git => 'https://github.com/mnorth719/MattKit.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '9.0'

  s.source_files = 'MattKit/Classes/**/*'

  # s.resource_bundles = {
  #   'MattKit' => ['MattKit/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  s.frameworks = 'UIKit'
  s.dependency 'PromiseKit', '~> 4.4'
end
