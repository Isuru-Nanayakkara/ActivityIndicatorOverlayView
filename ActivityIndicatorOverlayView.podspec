#
# Be sure to run `pod lib lint ActivityIndicatorOverlayView.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'ActivityIndicatorOverlayView'
  s.version          = '1.0.1'
  s.summary          = 'An view that can be used to cover the entire active screen when a task is performing.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
  						Sometimes apps need to perform long running tasks. Such as networking calls. 
  						During that time, you don't want impatient users tapping and messing around with the app UI.
  						ActivityIndicatorOverlayView is a view that can be presented while such a task is undergoing to stop interations with the UI.
                       DESC

  s.homepage         = 'https://github.com/Isuru-Nanayakkara/ActivityIndicatorOverlayView'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Isuru-Nanayakkara' => 'isuru.nan@gmail.com' }
  s.source           = { :git => 'https://github.com/Isuru-Nanayakkara/ActivityIndicatorOverlayView.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/bitinvent'

  s.ios.deployment_target = '13.0'

  s.source_files = 'ActivityIndicatorOverlayView/Classes/**/*'
  
  # s.resource_bundles = {
  #   'ActivityIndicatorOverlayView' => ['ActivityIndicatorOverlayView/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  s.frameworks = 'UIKit'
  # s.dependency 'AFNetworking', '~> 2.3'
  s.swift_version = '5.0'
end
