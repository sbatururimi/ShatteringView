#
# Be sure to run `pod lib lint ShatteringView.podspec' to ensure this is a
# valid spec and remove all comments before submitting the spec.
#
# Any lines starting with a # are optional, but encouraged
#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "ShatteringView"
  s.version          = "1.0.0"
  s.summary          = "A view with a splitting into pieces animation"
  s.homepage         = "https://github.com/virt87/ShatteringView"
  s.license          = 'MIT'
  s.author           = { "Stas Batururimi" => "blueocean87@me.com" }
  s.source           = { :git => "https://github.com/virt87/ShatteringView.git", :tag => 1.0.0 }
  # s.social_media_url = 'https://twitter.com/stas_robson'

  s.platform     = :ios, '7.1'
  s.requires_arc = true

  s.source_files = 'Pod/Classes/**/*'
  s.resource_bundles = {
    'ShatteringView' => ['Pod/Assets/*.png']
  }

  # s.public_header_files = 'Pod/Classes/**/*.h'
end
