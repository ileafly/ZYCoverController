#
# Be sure to run `pod lib lint ZYCoverController.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'ZYCoverController'
  s.version          = '0.1.0'
  s.summary          = 'A lightweight, pure-Swift library for cover flip.'

  s.homepage         = 'https://github.com/ileafly/ZYCoverController'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'leafly' => 'luzhiyongmail@sohu.com' }
  s.source           = { :git => 'https://github.com/ileafly/ZYCoverController.git', :tag => s.version.to_s }

  s.ios.deployment_target = '8.0'
  s.swift_version = "4.2"

  s.source_files = 'ZYCoverController/Classes/**/*'

end
