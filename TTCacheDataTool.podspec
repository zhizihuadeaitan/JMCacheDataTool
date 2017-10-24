#
#  Be sure to run `pod spec lint TTCacheDataTool.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#
Pod::Spec.new do |s|
  s.name         = "TTCacheDataTool"
  s.version      = “1.0.1”
  s.summary      = "SaveData"
  s.description  = <<-DESC
                   数据存储及展示。
                   DESC
  s.homepage     = "https://github.com/zhizihuadeaitan/TTCacheDataTool"
  # s.screenshots  = "www.example.com/screenshots_1.gif", "www.example.com/screenshots_2.gif"
  s.license          = 'MIT'
s.author             = { "Cindy" => "493761458@qq.com" }
  # Or just: s.author    = "Cindy"
  # s.authors            = { "Cindy" => "493761458@qq.com" }
   s.social_media_url   = "http://twitter.com/Cindy"

  s.source       = { :git => "https://github.com/zhizihuadeaitan/TTCacheDataTool.git", :tag => "#{s.version}" }

   # s.platform     = :ios
   s.platform     = :ios, "9.1"

  #  When using multiple platforms
  # s.ios.deployment_target = "5.0"
  # s.osx.deployment_target = "10.7"
  # s.watchos.deployment_target = "2.0"
  # s.tvos.deployment_target = "9.0"

  s.requires_arc = true
  s.source_files  = "TTCacheDataTool", "TTCacheDataTool/**/*.{h,m}"

  # s.public_header_files = "Classes/**/*.h"
  # s.resources = 'Assets'
  # s.framework  = "SomeFramework"
  s.frameworks = "UIKit"
  #s.dependency 'AFNetworking', '~> 2.3' 
  s.dependency 'YYModel', '~> 1.0.3'
  s.dependency 'SDAutoLayout', '~> 1.3'
  s.dependency 'AFNetworking', '~> 3.1.0'

  # s.library   = "iconv"
  # s.libraries = "iconv", "xml2"

end

