#
# Be sure to run `pod lib lint ShatteringView.podspec' to ensure this is a
# valid spec and remove all comments before submitting the spec.
#
# Any lines starting with a # are optional, but encouraged
#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |spec|
  spec.name             = "ShatteringView"
  spec.version          = "1.0.0"
  spec.summary          = "A view with a splitting into pieces animation"
  spec.homepage         = "https://github.com/virt87/ShatteringView"
  spec.license          = 'MIT'
  spec.author           = { "Stas Batururimi" => "blueocean87@me.com" }
  spec.source           = { :git => "https://github.com/virt87/ShatteringView.git", :tag => '1.0.0' }
  spec.social_media_url = 'https://twitter.com/stas_robson'

  spec.ios.deployment_target = '7.1'
  spec.requires_arc = true

  spec.source_files = 'Pod/Classes/**/*'
  spec.public_header_files = 'Pod/Classes/{ShatteringView}.h'
end
