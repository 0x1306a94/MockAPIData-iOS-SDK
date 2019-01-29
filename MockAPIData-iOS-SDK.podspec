Pod::Spec.new do |s|
  s.name             = 'MockAPIData-iOS-SDK'
  s.version          = '0.1.0'
  s.summary          = 'A short description of MockAPIData-iOS-SDK.'

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/0x1306a94/MockAPIData-iOS-SDK'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { '0x1306a94' => '0x1306a94@gamil.com' }
  s.source           = { :git => 'https://github.com/0x1306a94/MockAPIData-iOS-SDK.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  s.source_files = 'MockAPIData-iOS-SDK/Classes/**/*'
  
  # s.resource_bundles = {
  #   'MockAPIData-iOS-SDK' => ['MockAPIData-iOS-SDK/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  s.dependency 'AFNetworking'
  s.dependency 'YYModel'
end
