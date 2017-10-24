
Pod::Spec.new do |s|
  s.name         = 'TTCacheDataTool'
  s.version      = '1.0.1'
  s.license          = 'MIT'
  s.homepage     = 'https://github.com/zhizihuadeaitan/TTCacheDataTool'
  s.author             = { 'Cindy' => '493761458@qq.com' }
  s.summary      = '数据存储及展示'
  s.source       = { :git => 'https://github.com/zhizihuadeaitan/TTCacheDataTool.git', :tag => '1.0.1' }
  s.source_files  = 'TTCacheDataTool', 'TTCacheDataTool/**/*.{h,m}'
  s.requires_arc = true
  s.platform     = :ios, '9.1'
  s.frameworks = "UIKit"
  s.dependency 'YYModel', '~> 1.0.3'
  s.dependency 'SDAutoLayout', '~> 1.3'
  s.dependency 'AFNetworking', '~> 3.1.0'


end

